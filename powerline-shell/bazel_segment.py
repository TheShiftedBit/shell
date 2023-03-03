from powerline_shell.utils import BasicSegment, RepoStats
from powerline_shell.segments import cwd
import os

def override_cwd(powerline, bazel_subdir):
    while bazel_subdir[-1] == '/':
        bazel_subdir = bazel_subdir[0:-1]
    powerline.cwd = bazel_subdir


class Segment(BasicSegment):
    def add_to_powerline(self):
        val = os.environ.get('BAZEL_REPO_DIR')
        subdir = os.environ.get('BAZEL_SUBDIR')
        if val:
            fg = self.powerline.theme.BAZEL_REPO_FG if hasattr(self.powerline.theme, "BAZEL_REPO_FG") else self.powerline.theme.HOME_FG
            bg = self.powerline.theme.BAZEL_REPO_BG if hasattr(self.powerline.theme, "BAZEL_REPO_BG") else self.powerline.theme.HOME_BG
            self.powerline.append(f" {val} ", fg, bg)
        if subdir:
            override_cwd(self.powerline, subdir)


