import numpy as np
import matplotlib.pyplot as plt

# read xy.txt
with open("xy.txt", "r") as file:
    lines = file.readlines()
data = []
for line in lines[:-3]:
    data.append(line.split())
data = np.array(data, dtype=float)

# plot c60
plt.figure(figsize=(5, 5), dpi=100)
plt.scatter(data[:, 0], data[:, 1], s=0.4, c="black")
plt.xlim(60, 180)
plt.ylim(60, 180)
plt.xlabel(r"$x/\AA$")
plt.ylabel(r"$y/\AA$")
plt.tight_layout()
plt.savefig("graphene.jpg", dpi=200)

# read neighbor.txt
with open("neighbor.txt", "r") as file:
    lines = file.readlines()
# drop NaN
neighbors = []
for line in lines:
    value = []
    for v in line.split():
        if v != "NaN":
            value.append(int(v))
    neighbors.append(value)

# generate bond coordinate for each particle
bonds = {}
for i, n in enumerate(neighbors):
    bond = []
    for index in n[1:]:
        if data[i][0] < 60 or data[i][0] > 180 or data[i][1] < 60 or data[i][1] > 180:
            break
        bond.append(data[i])
        bond.append(data[index])
    bonds[i] = np.array(bond)

# plot particles and bonds
plt.figure(figsize=(5, 5), dpi=100)
plt.scatter(data[:, 0], data[:, 1], s=0.4, c="black")
for key in bonds.keys():
    print(f"{key}/22464")
    if bonds[key].size > 0:    
        for i in range(0, len(bonds[key]), 2):
            plt.plot(bonds[key][i:i+2, 0], bonds[key][i:i+2, 1], "r-", linewidth=0.4)
plt.xlim(60, 180)
plt.ylim(60, 180)
plt.xlabel(r"$x/\AA$")
plt.ylabel(r"$y/\AA$")
plt.tight_layout()
plt.savefig("graphene_bond.jpg", dpi=200)