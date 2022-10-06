#include <string>
#include <filesystem>
#include <iostream>
#include <optional>

using std::filesystem::path;

std::optional<path> find_root(path curpath) {
    while (true) {
            if (std::filesystem::exists(curpath / "WORKSPACE")) {
                return curpath;
            }
        if (curpath == curpath.parent_path()) {
            return std::nullopt;
        }
        curpath = curpath.parent_path();
    } 
    return curpath;
}

int main(int argc, char** argv) {
    std::string directory;
    if (argc > 2) {
        directory = argv[1];
    } else {
        directory = ".";
    }
    path curpath = std::filesystem::absolute(directory);
    std::optional<path> maybe_root = find_root(curpath);
    if (!maybe_root) {
        return 1;
    }
    path root = std::move(*maybe_root);
    path subdir;
    if (curpath != root) {
        subdir = curpath.lexically_relative(root);
    }

    if (subdir.filename() == ".") {
        std::cout << "truncating subdir" << std::endl;
        subdir = subdir.parent_path();
    }
    if (root.filename() == ".") {
        std::cout << "truncating root" << std::endl;
        root = root.parent_path();
    }
    
    path bazel_bin = root / "bazel-bin" / subdir;
    path bazel_testlogs = root / "bazel-testlogs" / subdir;
    
    std::string bazel_repo_dir = root.filename().string();
    path bazel_workdir = root / ("bazel-" + bazel_repo_dir);
    path bazel_external = bazel_workdir / "external";

    std::cout << "BAZEL_SUBDIR=" << (subdir / "") << std::endl;
    std::cout << "BAZEL_ROOT=" << (root / "") << std::endl;
    std::cout << "BAZEL_BIN=" << (bazel_bin / "") << std::endl;
    std::cout << "BAZEL_TESTLOGS=" << (bazel_testlogs / "") << std::endl;
    std::cout << "BAZEL_WORKDIR=" << (bazel_workdir / "") << std::endl;
    std::cout << "BAZEL_EXTERNAL=" << (bazel_external / "") << std::endl;
    std::cout << "BAZEL_REPO_DIR=" << bazel_repo_dir << std::endl;

    return 0;
}
