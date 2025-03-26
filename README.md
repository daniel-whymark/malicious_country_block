# Malicious Country Block
## Blocks malicious countries in iptables with ipset blocklists

### Usage
Running this script will block *all* IPv4 and IPv6 traffic from the listed countries, deemed malicious due to their high rates of cybercrime.

This list is tailored to a specific server/cloud's particular use cases and geographic location, <ins>you must ensure</ins> that you do not block a country you operate in.

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
