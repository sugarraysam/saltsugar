{% set home = grains['sugar']['user_home'] %}
{% set gopath = home + "/.go" %}
{% set gobin = gopath + "/bin" %}

go:
  gopath: {{ gopath }}
  gobin: {{ gobin }}
  pkgs:
    - go # Core compiler tools for the Go programming language
    - gopls # Language server for Go programming language
    - go-tools # Developer tools for the Go programming language
    - protobuf # Protocol Buffers - Google's data interchange format
  dirs:
    - { path: {{ gopath }} }
    - { path: {{ gobin }} }
  gh_binaries:
    - {
        repo: "golangci/golangci-lint",
        urlfmt: "https://github.com/golangci/golangci-lint/releases/download/{tag}/golangci-lint-{tag_no_v}-linux-amd64.tar.gz",
      }
    - {
        repo: "fullstorydev/grpcurl",
        urlfmt: "https://github.com/fullstorydev/grpcurl/releases/download/{tag}/grpcurl_{tag_no_v}_linux_x86_64.tar.gz",
      }
    - {
        repo: "goreleaser/goreleaser",
        urlfmt: "https://github.com/goreleaser/goreleaser/releases/download/{tag}/goreleaser_Linux_x86_64.tar.gz",
      }
  gopkgs:
    - { name: cobra, url: github.com/spf13/cobra/cobra } # CLI program generator (was failing on 11-05-2021)
    - { name: protoc, url: google.golang.org/protobuf } # protoc plugin
    - { name: protoc_grpc, url: google.golang.org/protobuf/cmd/protoc-gen-go } # protoc grpc plugin
    - { name: ocm, url: github.com/openshift-online/ocm-cli/cmd/ocm } # ocm redhat
    - { name: cfssl, url: github.com/cloudflare/cfssl/cmd/cfssl } # CloudFlare's PKI/TLS toolkit
    - { name: cfssljson, url: github.com/cloudflare/cfssl/cmd/cfssljson } # cfssljson utility
  cmds:
    - { id: "clean_cache", cmd: "go clean -cache" } # cleans $HOME/.cache/go-build
    - { id: "clean_modcache", cmd: "go clean -modcache" } # cleans $GOPATH/pkg/mod
  zsh_completions:
    - "ocm completion zsh > /usr/share/zsh/site-functions/_ocm"
