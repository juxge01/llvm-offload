# plot_candidates.py
"""Visualize fusion‑candidate statistics (v0.2)

Features
--------
* Scatter plot – FLOPs (x) vs Bytes (y), marker size ∝ gain.
* Optional gain histogram with --hist.
* Graceful handling when JSON is empty or ptp=0.

Usage
-----
$ python plot_candidates.py --input cand.json [--save scatter.png] [--hist] [--show]
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import List, Dict, Any

import numpy as np
import matplotlib.pyplot as plt

###############################################################################
# Helpers
###############################################################################


def load(path: Path) -> List[Dict[str, Any]]:
    if not path.exists():
        sys.exit(f"[ERR] {path} not found")
    with open(path) as f:
        return json.load(f)


def scatter(cands: List[Dict[str, Any]], save: Path | None, show: bool):
    if not cands:
        sys.exit("[ERR] No candidates to plot – JSON is empty.")

    flops = np.array([c["total_flops"] for c in cands])
    bytes_ = np.array([c["total_bytes"] for c in cands])
    gain = np.array([c["gain"] for c in cands])

    # size scaling – protect against ptp == 0
    if gain.ptp() == 0:
        sizes = np.full_like(gain, 100)
    else:
        sizes = (gain - gain.min()) / gain.ptp() * 300 + 30

    plt.figure()
    plt.scatter(flops, bytes_, s=sizes, alpha=0.7, edgecolors="w")
    plt.xlabel("Total FLOPs")
    plt.ylabel("Total Bytes")
    plt.title("Fusion‑Candidates Scatter")
    plt.xscale("log")
    plt.yscale("log")
    plt.grid(True, which="both", ls="--", lw=0.5)

    if save:
        save.parent.mkdir(parents=True, exist_ok=True)
        plt.savefig(save, dpi=300, bbox_inches="tight")
        print(f"Saved scatter → {save}")
    if show:
        plt.show()
    plt.close()


def hist_gain(cands: List[Dict[str, Any]]):
    gain = np.array([c["gain"] for c in cands])
    plt.figure()
    plt.hist(gain, bins="auto")
    plt.xlabel("gain")
    plt.ylabel("count")
    plt.title("Gain Distribution")
    plt.grid(True, ls="--", lw=0.5)
    plt.show()

###############################################################################
# CLI
###############################################################################


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input", required=True)
    ap.add_argument("--save", type=str)
    ap.add_argument("--hist", action="store_true")
    ap.add_argument("--show", action="store_true")
    args = ap.parse_args()

    cands = load(Path(args.input))
    scatter(cands, Path(args.save) if args.save else None, args.show)
    if args.hist:
        hist_gain(cands)


if __name__ == "__main__":
    main()
