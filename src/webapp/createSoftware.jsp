<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Software</title>
</head>
<body>
    <h2>Create New Software</h2>
    <form action="software" method="post">
        Software Name: <input type="text" name="softwareName" required><br>
        Description: <textarea name="description" required></textarea><br>
        Access Levels: 
        <input type="checkbox" name="accessLevels" value="Read"> Read
        <input type="checkbox" name="accessLevels" value="Write"> Write
        <input type="checkbox" name="accessLevels" value="Admin"> Admin<br>
        <input type="submit" value="Create Software">
    </form>
</body>
</html>
