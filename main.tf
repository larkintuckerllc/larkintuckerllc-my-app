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

resource "heroku_addon" "postgres" {
  app = heroku_app.this.id
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_build" "this" {
  depends_on = [heroku_addon.postgres]
  app = heroku_app.this.id
  source = {
    path = "./app"
  }

  provisioner "local-exec" {
    command = "bash ./scripts/health-check ${heroku_app.this.web_url}"
  }
}

output "web_url" {
  value = heroku_app.this.web_url 
}
