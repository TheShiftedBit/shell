from powerline_shell.utils import BasicSegment, RepoStats
from powerline_shell.segments import cwd
import os

def override_cwd(powerline, bazel_subdir):
    while len(bazel_subdir) and bazel_subdir[-1] == '/':
        bazel_subdir = bazel_subdir[0:-1]
    if not len(bazel_subdir):
        bazel_subdir = "/"
    powerline.cwd = bazel_subdir


class Segment(BasicSegment):
    def add_to_powerline(self):
        in_repo = os.environ.get('BAZEL_IN_REPO')
        val = os.environ.get('BAZEL_REPO_DIR')
        subdir = os.environ.get('BAZEL_SUBDIR')
        if in_repo and not int(in_repo):
            fg = self.powerline.theme.BAZEL_REPO_FG if hasattr(self.powerline.theme, "BAZEL_REPO_FG") else self.powerline.theme.HOME_FG
            bg = self.powerline.theme.BAZEL_REPO_BG if hasattr(self.powerline.theme, "BAZEL_REPO_BG") else self.powerline.theme.HOME_BG
            self.powerline.append(f" {val} ", fg, bg)
            override_cwd(self.powerline, subdir)


