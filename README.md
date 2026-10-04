# JellyCAD-vcpkg

为 [JellyCAD](https://github.com/Jelatine/JellyCAD) 预编译 vcpkg 依赖 (lua sol2 qtbase opencascade gtest)，产物存放于 Release。

## 生成

Actions → **Build vcpkg** → Run workflow，输入 vcpkg 版本 (如 `2026.06.24`)。
产物发布到 tag `vcpkg-<版本>`，每个平台一组分卷：

- `vcpkg-Windows.tar.gz.part-*`
- `vcpkg-Linux.tar.gz.part-*`
- `vcpkg-macOS.tar.gz.part-*`

## 构建环境

| 平台 | Runner | 编译器 |
|---|---|---|
| Windows | `windows-2025-vs2026` | Visual Studio 2026 (x64) |
| Linux | `ubuntu-24.04` | GCC |
| macOS | `macos-26` | Apple Clang (arm64) |

产物仅适用于相同系统和编译器，其他环境请自行用 vcpkg 编译。

## 使用

在 JellyCAD 源码目录下执行（Windows 请使用 Git Bash）：

```bash
gh release download vcpkg-2026.06.24 -R Jelatine/JellyCAD-vcpkg -p "vcpkg-${RUNNER_OS}.tar.gz.part-*" -D vcpkg_dl
cat vcpkg_dl/* | tar -xzf -
cmake -B build -DCMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake
```
