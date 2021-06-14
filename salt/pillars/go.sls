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
  cmds:
    - {
        id: "install_cobra",
        cmd: "go get -u github.com/spf13/cobra/cobra || true", # CLI program generator (was failing on 11-05-2021)
      }
    - {
        id: "install_protoc",
        cmd: "go get google.golang.org/protobuf/cmd/protoc-gen-go", # protoc plugin
      }
    - {
        id: "install_grpc",
        cmd: "go get google.golang.org/grpc/cmd/protoc-gen-go-grpc", # protoc grpc plugin
      }
    - {
        id: "install_ocm",
        cmd: "go get -u github.com/openshift-online/ocm-cli/cmd/ocm", # ocm redhat
      }
    - {
        id: "clean_cache",
        cmd: "go clean -cache", # cleans $HOME/.cache/go-build
      }
    - {
        id: "clean_modcache",
        cmd: "go clean -modcache", # cleans $GOPATH/pkg/mod
      }
  zsh_completions:
    - "ocm completion zsh > /usr/share/zsh/site-functions/_ocm"
