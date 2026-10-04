# JellyCAD-vcpkg

为 [JellyCAD](https://github.com/Jelatine/JellyCAD) 预编译 vcpkg 依赖 (lua sol2 qtbase opencascade gtest)，产物存放于 Release。

## 生成

Actions → **Build vcpkg** → Run workflow，输入 vcpkg 版本 (如 `2026.06.24`)。
产物发布到 tag `vcpkg-<版本>`，每个平台一组分卷：

- `vcpkg-Windows.tar.gz.part-*`
- `vcpkg-Linux.tar.gz.part-*`
- `vcpkg-macOS.tar.gz.part-*`

## 使用

```bash
gh release download vcpkg-2026.06.24 -R Jelatine/JellyCAD-vcpkg -p "vcpkg-${RUNNER_OS}.tar.gz.part-*" -D vcpkg_dl
cat vcpkg_dl/* | tar -xzf -
cmake -B build -DCMAKE_TOOLCHAIN_FILE=vcpkg/scripts/buildsystems/vcpkg.cmake
```
