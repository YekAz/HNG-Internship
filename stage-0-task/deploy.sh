#!/bin/bash
# Update the package index
sudo apt update -y

# Install Apache
sudo apt install apache2 -y

# Start Apache and enable it to start at boot
sudo systemctl start apache2
sudo systemctl enable apache2

# Create website directory
sudo mkdir -p /var/www/mywebsite

# Create an HTML file
cat <<EOT > /var/www/mywebsite/index.html
<!DOCTYPE html>
<html>
<head>
    <title>My Static Website</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>Welcome to My Static Website</h1>
    <p>This site is hosted on an AWS EC2 instance.</p>
    <p>HNG Internship</p>
    <a href="https://hng.tech" target="_blank">HNG.tech</a>
    <p>Name: <b>YEKINNI AZEEZ</b> </p>
    <p>Username: YEKINNI AZEEZ </p>
    <p>Email: yekinniazeez55@gmail.com </p>
    
    <button id="changeColorButton">Change Background Color</button>

    <script src="script.js"></script>
</body>
</html>
EOT

# Create a CSS file
cat <<EOT > /var/www/mywebsite/styles.css
body {
    font-family: Arial, sans-serif;
    text-align: center;
    margin-top: 50px;
}

h1 {
    color: #333;
}

p {
    color: #555;
}

button {
    padding: 10px 20px;
    background-color: #007BFF;
    color: white;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}
EOT

# Create a JavaScript file
cat <<EOT > /var/www/mywebsite/script.js
document.getElementById('changeColorButton').addEventListener('click', function() {
    document.body.style.backgroundColor = getRandomColor();
});

function getRandomColor() {
    const letters = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}
EOT

# Copy website files to the Apache web directory
sudo cp -r /var/www/mywebsite/* /var/www/html/

# Restart Apache to apply changes
sudo systemctl restart apache2
