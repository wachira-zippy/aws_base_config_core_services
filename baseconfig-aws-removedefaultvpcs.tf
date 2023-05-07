provider "awsutils" {
  region = "us-east-1"
}

provider "awsutils" {
  alias  = "us-east-2"
  region = "us-east-2"
}

provider "awsutils" {
  alias  = "us-west-1"
  region = "us-west-1"
}

provider "awsutils" {
  alias  = "us-west-2"
  region = "us-west-2"
}

/* provider "awsutils" {
  alias  = "af-south-1"
  region = "af-south-1"
} */

/* provider "awsutils" {
  alias  = "ap-east-1"
  region = "ap-east-1"
} */

# provider "awsutils" {
#   alias   = "ap-southeast-3"
#   region  = "ap-southeast-3"
# }

provider "awsutils" {
  alias  = "ap-south-1"
  region = "ap-south-1"
}

provider "awsutils" {
  alias  = "ap-northeast-3"
  region = "ap-northeast-3"
}

provider "awsutils" {
  alias  = "ap-northeast-2"
  region = "ap-northeast-2"
}

provider "awsutils" {
  alias  = "ap-northeast-1"
  region = "ap-northeast-1"
}

provider "awsutils" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
}

provider "awsutils" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}

provider "awsutils" {
  alias  = "ca-central-1"
  region = "ca-central-1"
}

provider "awsutils" {
  alias  = "eu-central-1"
  region = "eu-central-1"
}

provider "awsutils" {
  alias  = "eu-west-1"
  region = "eu-west-1"
}

provider "awsutils" {
  alias  = "eu-west-2"
  region = "eu-west-2"
}

/* provider "awsutils" {
  alias  = "eu-south-1"
  region = "eu-south-1"
} */

provider "awsutils" {
  alias  = "eu-west-3"
  region = "eu-west-3"
}

provider "awsutils" {
  alias  = "eu-north-1"
  region = "eu-north-1"
}

/* provider "awsutils" {
  alias  = "me-south-1"
  region = "me-south-1"
} */

provider "awsutils" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}

resource "awsutils_default_vpc_deletion" "us-east-1" {
}

resource "awsutils_default_vpc_deletion" "us-east-2" {
  provider = awsutils.us-east-2
}

resource "awsutils_default_vpc_deletion" "us-west-1" {
  provider = awsutils.us-west-1
}

resource "awsutils_default_vpc_deletion" "us-west-2" {
  provider = awsutils.us-west-2
}

/* resource "awsutils_default_vpc_deletion" "af-south-1" {
  provider = awsutils.af-south-1
} */

/* resource "awsutils_default_vpc_deletion" "ap-east-1" {
  provider = awsutils.ap-east-1
} */

# resource "awsutils_default_vpc_deletion" "ap-southeast-3" {
#   provider = awsutils.ap-southeast-3
# }

resource "awsutils_default_vpc_deletion" "ap-south-1" {
  provider = awsutils.ap-south-1
}

resource "awsutils_default_vpc_deletion" "ap-northeast-3" {
  provider = awsutils.ap-northeast-3
}

resource "awsutils_default_vpc_deletion" "ap-northeast-2" {
  provider = awsutils.ap-northeast-2
}

resource "awsutils_default_vpc_deletion" "ap-northeast-1" {
  provider = awsutils.ap-northeast-1
}

resource "awsutils_default_vpc_deletion" "ap-southeast-2" {
  provider = awsutils.ap-southeast-2
}

resource "awsutils_default_vpc_deletion" "ap-southeast-1" {
  provider = awsutils.ap-southeast-1
}

resource "awsutils_default_vpc_deletion" "ca-central-1" {
  provider = awsutils.ca-central-1
}

resource "awsutils_default_vpc_deletion" "eu-central-1" {
  provider = awsutils.eu-central-1
}

resource "awsutils_default_vpc_deletion" "eu-west-1" {
  provider = awsutils.eu-west-1
}

resource "awsutils_default_vpc_deletion" "eu-west-2" {
  provider = awsutils.eu-west-2
}

/* resource "awsutils_default_vpc_deletion" "eu-south-1" {
  provider = awsutils.eu-south-1
} */

resource "awsutils_default_vpc_deletion" "eu-west-3" {
  provider = awsutils.eu-west-3
}

resource "awsutils_default_vpc_deletion" "eu-north-1" {
  provider = awsutils.eu-north-1
}

/* resource "awsutils_default_vpc_deletion" "me-south-1" {
  provider = awsutils.me-south-1
} */

resource "awsutils_default_vpc_deletion" "sa-east-1" {
  provider = awsutils.sa-east-1
}
