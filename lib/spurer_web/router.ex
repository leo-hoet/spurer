defmodule SpurerWeb.Router do
  use SpurerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SpurerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SpurerWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/proc", ProcessLive
    live "/buckets", BucketsLive
    live "/svelte", DemoSvelte
  end

  scope "/api", SpurerWeb do
    pipe_through :api
    resources "/urls", UrlController, except: [:new, :edit]
    resources "/locations", LocationController, except: [:new, :edit]
    resources "/buckets", BucketController, except: [:new, :edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:spurer, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SpurerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
