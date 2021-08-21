db.createUser({
    user: "user",
    pwd: "password",
    roles: [
        {
            role: "readWrite",
            db: "mongodb_userdb"
        }
    ]
});
