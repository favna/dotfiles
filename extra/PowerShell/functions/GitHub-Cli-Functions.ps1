Function gh-prc {
    gh pr checkout @Args
}

Function gh-pra {
    gh pr review -a @Args
}

Function gh-prd {
    gh pr review -d @Args
}

Function gh-pview {
    gh pr view -w
}

Function gh-view {
    gh repo view -w
}