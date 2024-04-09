{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell {
  buildInputs =
    [ yq-go kustomize kubeconform kubectl kubeseal fluxcd weave-gitops ];
}
