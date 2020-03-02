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

resource "heroku_app" "this" {
  name   = "larkintuckerllc-my-app"
  region = "us"
}

resource "heroku_build" "this" {
  app = heroku_app.this.id

  source = {
    path = "./app"
  }
}

output "web_url" {
  value = heroku_app.this.web_url 
}
