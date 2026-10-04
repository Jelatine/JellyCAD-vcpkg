#!/usr/bin/env bash
# 将 vcpkg 目录打包为 tar.gz，按 1900MB 分卷(Release单个文件上限2GB)后上传到 Release
# 产物命名: vcpkg-<RUNNER_OS>.tar.gz.part-aa, -ab, ...
# 依赖环境变量: RELEASE_TAG, RUNNER_OS, GH_TOKEN, GH_REPO
set -euo pipefail

PREFIX="vcpkg-${RUNNER_OS}.tar.gz.part-"

mkdir -p dist
tar -czf - vcpkg | split -b 1900m - "dist/${PREFIX}"
ls -lh dist

# 删除该平台旧的分卷(分卷数量可能变化)
gh release view "$RELEASE_TAG" --json assets -q '.assets[].name' | while read -r name; do
  case "$name" in
    "$PREFIX"*) gh release delete-asset "$RELEASE_TAG" "$name" -y ;;
  esac
done

gh release upload "$RELEASE_TAG" dist/* --clobber
