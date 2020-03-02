package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"gotest.tools/assert"
)

var githubOrganization, githubToken string

func init() {
	githubOrganization = os.Getenv("GITHUB_ORGANIZATION")
	githubToken = os.Getenv("GITHUB_TOKEN")

	if githubOrganization == "" {
		panic("Please set a github organization using the GITHUB_ORGANIZATION environment variable.")
	}

	if githubToken == "" {
		panic("Please set a github token using the GITHUB_TOKEN environment variable.")
	}
}

func TestGithubTeam(t *testing.T) {
	t.Parallel()

	repositoryA := fmt.Sprintf("a-repository-%s", random.UniqueId())
	repositoryB := fmt.Sprintf("b-repository-%s", random.UniqueId())
	teamName := fmt.Sprintf("team-%s", random.UniqueId())

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "../examples/public-repository-with-team",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"team_name":         teamName,
			"a-repository-name": repositoryA,
			"b-repository-name": repositoryB,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Validate the names of the repositoriees
	assert.Equal(t, repositoryA, terraform.Output(t, terraformOptions, "first_repository_name"))
	assert.Equal(t, repositoryB, terraform.Output(t, terraformOptions, "second_repository_name"))

	// Validate if the created teams name
	assert.Equal(t, teamName, terraform.Output(t, terraformOptions, "team_name"))
}
