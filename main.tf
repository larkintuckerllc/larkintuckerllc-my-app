terraform {
  backend "remote" {
    organization = "larkin_tucker_llc"

    workspaces {
      name = "larkintuckerllc-my-app"
    }
  }
}

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
    path = "./app"
  }
}

output "web_url" {
  value = heroku_app.larkintuckerllc-my-app.web_url 
}
