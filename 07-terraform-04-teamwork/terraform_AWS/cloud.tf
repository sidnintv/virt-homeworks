terraform {
  cloud {
    organization = "company_softcore"

    workspaces {
      name = "test"
    }
  }
}
