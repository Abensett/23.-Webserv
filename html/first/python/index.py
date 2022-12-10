#!/usr/bin/python3

# Import CGI and CGIT module
import cgi, cgitb
# form = cgi.FieldStorage()

print ("Content-type:text/html")
print()
print ("<html>")
print ("<head>")
print ("<title>First CGI Program</title>")
print ("</head>")
print ("<body>")
print ("<h2>Hello, %s is working in %s</h2>")

print ("</body>")
print ("</html>")