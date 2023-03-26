import sys
from pathlib import Path

print(Path.cwd())
sys.path.append(Path.cwd().joinpath("advent").as_posix())
import day_12