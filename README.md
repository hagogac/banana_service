# The Banana Service

Scope: 

Exercise 1 \
Write a little script reading from stdin. The script should fulfill the following technical
requirements: Read an input stream from stdin. Every time the word banana is contained in the stream write an ASCII minion to the logs.

Exercise 2 \
Extend the script to be a service opening a TCP socket listening on port 6987 and reading from it. The service MUST fulfill the following technical requirements: 
* Configured using systemd.
* Be launched at boot time.
* Restart upon crash.
* Firewall MUST be configured to allow access to service only from local network.

## Prerequisites

Ubuntu 20.04   
bash v.5 and up \
nc (netcat) \
ufw \
netstat (optional)

Check the version of bash with:

```bash
apt info bash
```
Check if nc and ufw are installed. 

```bash
which nc
which ufw
```
Check if the firewall is active. If not, enable the firewall on boot:
```bash
sudo ufw status
sudo ufw enable
```

## Usage
Exercise 1.

Select the script directory/location, make the script executable, execute the script. Check banana.log in the current directory for the number of minions.

```bash
cd <folder_where_bananascript.sh_is>
chmod +x bananascript.sh
./bananascript.sh
```

Exercise 2.\
As superuser: \
Step 1. Copy bananasocket.service to /etc/systemd/system/ \
Step 2. Copy bananascript.sh to /usr/local/bin/ \
Step 3. Reload systemd with this new unit \
Step 4. To start the script on boot, enable the service:

```bash
cd <folder_where_the_service_unit_file_and_script_are>
sudo cp bananasocket.service /etc/systemd/system
sudo cp bananascript.sh /usr/local/bin
sudo systemctl daemon-reload
sudo systemctl enable bananasocket.service
```
Configure the firewall to allow access to the service only from the local network. Check the available network interfaces:
```bash
ip -c a
```
Assume eth0 as primary interface and 192.168.1.0 as the private IP of the machine (one host):
```bash
sudo ufw allow in on eth0 proto tcp from 192.168.1.0/32 to any port 6987
```

## Testing
Check if the service is running:
```bash
sudo systemctl status bananasocket.service
```
Send a message from a client on TCP port 6987: Run bananascript.sh. Open a new terminal or terminal tab and establish a connection from the client:
```bash
nc localhost 6987
hello server
```
Expected result:

```bash
Server listening on TCP port 6987. Terminate socket with CTRL+C
hello server
````

Optional: Verify socket communication with netstat

```bash
netstat | grep 6987
tcp        0      0 localhost:59822         localhost:6987          ESTABLISHED
tcp        0      0 localhost:6987          localhost:59822         ESTABLISHED
unix  3      [ ]         STREAM     CONNECTED     46987    
````

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[GPL](https://choosealicense.com/licenses/gpl-3.0/)
