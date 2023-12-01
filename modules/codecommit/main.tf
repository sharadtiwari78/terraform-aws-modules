#create codecommit repository
data "aws_codecommit_repository" "codecommit_repository" {
  repository_name = "${var.repository_name}"
}



