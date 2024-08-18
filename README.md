# tailbash
Tailbash is a simple bash script modifying /etc/hosts based on the "tailscale status" output

awk is required
tailscale is required

The program assumes the "tailscale status" command gives an output resembling the following:

100.x.x.x  hostname1        test@         linux   -
100.x.x.x  hostname2        test@         freebsd -
100.x.x.x  hostname3        test@         windows -

Usage:

Dry-run:
tailbash.sh example.com --dry-run | tailscale status

Modify /etc/hosts:
sudo tailbash.sh example.com | tailscale status


Note: JSON is another possibility, but apparently the output is not "stable" (according to the tailscale output, anyway).
If JSON is more to your liking, a similar project using python can be found here: https://github.com/mxbi/tailscale-hostmap
