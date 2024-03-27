from powerline_shell.utils import BasicSegment, RepoStats
from powerline_shell.segments import cwd
import os

class Segment(BasicSegment):
    def add_to_powerline(self):
        ssh_identity = os.environ.get('SSH_IDENTITY', '')
        if ssh_identity:
            fg = self.powerline.theme.BAZEL_REPO_FG if hasattr(self.powerline.theme, "BAZEL_REPO_FG") else self.powerline.theme.HOME_FG
            bg = self.powerline.theme.BAZEL_REPO_BG if hasattr(self.powerline.theme, "BAZEL_REPO_BG") else self.powerline.theme.HOME_BG
            self.powerline.append(f" {ssh_identity} ", fg, bg)


