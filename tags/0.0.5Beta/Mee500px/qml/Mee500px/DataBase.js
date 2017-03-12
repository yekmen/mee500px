var _db;
function openDB() {
    _db = openDatabaseSync("Mee500px","1.0","Base de donne sauvegarde",1000000)
    createTable();
}

function clearTable(){
    openDB();
    _db.transaction( function(tx) {
    // Create the database if it doesn't already exist
        tx.executeSql('DROP TABLE IF EXISTS mee500px_oauth');
           }
    )
}
function createTable(){
    _db.transaction( function(tx) {
    // Create the database if it doesn't already exist
        tx.executeSql('CREATE TABLE IF NOT EXISTS mee500px_oauth(id INTEGER PRIMARY KEY, token NUMERIC, secret NUMERIC, auth BOOLEAN)');
           }
    )
}
function initTable(token, secret){
    clearTable();       //Remove old token
    openDB();
    _db.transaction( function(tx) {
                        tx.executeSql('INSERT INTO mee500px_oauth VALUES ((SELECT max(id) FROM mee500px_oauth)+ 1,?,?,?)', [token,secret, true]);
        }
    )
}
function authentified(){
    openDB();
    var r = ""
    _db.transaction( function(tx) {
            var rs = tx.executeSql('SELECT auth FROM mee500px_oauth');
            for(var i = 0; i < rs.rows.length; i++) {
                    r = rs.rows.item(i).auth
            }
        }
    )
    return r;
}

function getToken(){
    openDB();
    var r = ""
    _db.transaction( function(tx) {
            var rs = tx.executeSql('SELECT token FROM mee500px_oauth');
            for(var i = 0; i < rs.rows.length; i++) {
                    r = rs.rows.item(i).token
            }
        }
    )
    return r;
}
function getSecret(){
    openDB();
    var r = ""
    _db.transaction( function(tx) {
            var rs = tx.executeSql('SELECT secret FROM mee500px_oauth');
            for(var i = 0; i < rs.rows.length; i++) {
                    r = rs.rows.item(i).secret
            }
        }
    )
    return r;
}

function show(){
    openDB();
    _db.transaction( function(tx) {
        var r = ""
        var rs = tx.executeSql('SELECT * FROM mee500px_oauth');
        for(var i = 0; i < rs.rows.length; i++) {
            r += rs.rows.item(i).token + " , " + rs.rows.item(i).secret + "\n"
            }
            console.log("Dans la base de donnee : " + r)
        }
    )
}
