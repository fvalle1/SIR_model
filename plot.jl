using DataFrames
using CSV
using PyPlot

df = CSV.read("bullettin.csv");
names(df)

fig, ax = PyPlot.subplots(figsize=(18,15))
ax.plot(df.day, df.susceptible, lw=10, label="Susceptible")
ax.plot(df.day, df.infectus, lw=10, label="Infectus")
ax.plot(df.day, df.recovered, lw=10, label="Recovered")

ax.set_xlabel("Days", fontsize=35)
ax.set_ylabel("Count", fontsize=35)

ax.tick_params(labelsize=35)

ax.legend(fontsize=35)
PyPlot.show()
