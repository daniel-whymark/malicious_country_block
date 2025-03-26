# iptables Malicious Countries
## Block Malicious Countries with ipset Blocklists

### Usage
Running this script will block *all* IPv4 and IPv6 traffic from the listed countries, deemed malicious due to their high rates of cybercrime.

The commands add DROP rules to both the INPUT and DOCKER-USER iptables chains. This ensures coverage in case of externally exposed containers that would otherwise bypass this protection.

### Countries 
- China
- Russia
- Ukraine
- India
- Iran
- Vietnam
- Brazil
- Thailand
- Indonesia
- Pakistan
- Algeria

### References
- The target list was asembled based on the compiled [World Cybercrime Index](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0297312).
- The IP ranges are sourced from [ipdeny.com](ipdeny.com). 
