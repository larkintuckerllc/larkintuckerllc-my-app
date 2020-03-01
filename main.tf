provider "heroku" {
  version = "~> 2.0"
}

resource "heroku_app" "larkintuckerllc-my-app" {
  name   = "larkintuckerllc-my-app"
  region = "us"
}

resource "heroku_build" "larkintuckerllc-my-app_build" {
  app = heroku_app.larkintuckerllc-my-app.id

  source = {
    path = "."
  }
}
