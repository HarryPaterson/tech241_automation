<h1 style="text-align: center;">Reverse Proxy</h1>

### Contents
* What are ports?
* What is a reverse proxy?
* Managing file permissions
* Solution

### What are ports?
   In computer networking, a port is a communication endpoint used for identifying specific processes or services on a networked device. Ports allow multiple applications to coexist on the same device by assigning unique numbers to each application.

### What is a reverse proxy?
   A reverse proxy is a server that sits between client devices and web servers, forwarding client requests to the appropriate server. It acts on behalf of the server and provides additional functionalities such as load balancing, caching, SSL termination, and security features. In contrast, a forward proxy (commonly referred to as a proxy server) forwards client requests to the internet on behalf of the clients.

Diagram:

   ```
   +--------------+         +--------------+
   |  Client      |         |  Web Server  |
   +--------------+         +--------------+
          |                          ^
          | HTTP Request             |
          |--------------------------|
          |                          |
          v                          |
   +--------------+                  |
   | Reverse      |                  |
   | Proxy Server |                  |
   +--------------+                  |
          |                          |
          | HTTP Request             |
          |--------------------------|
          |                          |
          v                          |
   +--------------+                  |
   |  Web Server  |                  |
   +--------------+                  |
                                     |
   (Additional functionality, e.g., load balancing, caching, etc.)
   ```

### Nginx's default configuration 
   By default, Nginx's configuration files can be found in the `/etc/nginx` directory. The main configuration file is `nginx.conf`, and the directory `sites-available` contains the individual site configuration files.

   - Create or modify a site configuration file in the `sites-available` directory (e.g., `/etc/nginx/sites-available/myapp.conf`).
   - Configure Nginx to listen on a specific port (e.g., port 80) and define the server name.
   - Set up a location block to define the URL path and the backend server's address and port where the requests should be forwarded.
   - Enable the site by creating a symbolic link from `sites-available` to `sites-enabled` directory.
   - Restart Nginx to apply the changes.


### Solution

1. Create an Nginx configuration file for your app:
   ```
   sudo nano /etc/nginx/sites-available/
   ```
   This will open a text editor. Add the following configuration to the file:
   ```
   server {
       listen 80;
       server_name 4.234.113.95;

       location / {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }

       location /posts {
           proxy_pass http://localhost:3000/posts;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

2. Enable the site by creating a symbolic link in the `sites-enabled` directory:
   ```
   sudo ln -s /etc/nginx/sites-available/myapp.conf /etc/nginx/sites-enabled/
   ```

3. Test the Nginx configuration for any syntax errors:
   ```
   sudo nginx -t
   ```

4. Restart Nginx to apply the changes:
   ```
   sudo systemctl restart nginx
   ```
