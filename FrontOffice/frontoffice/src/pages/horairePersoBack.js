route.post("/api/addHorairePerso/:reference",cors(),async(req,res)=>{
      let refCentre= req.params.reference
      let sql5="INSERT INTO heure (CinPersonnel,refHoraire) values (?,?)"
                        
      connection.query(sql5,[refCentre,1],(error) => {
        if(error){
            res.send({ status: false, message: "Service created Failed"});
            console.log(" not ok"+error)
        } else {
          let sql5="INSERT INTO heure set ?"
        let details4 = {
          CinPersonnel:refCentre,
          refHoraire:2,
      };
      connection.query(sql5,details4,(error) => {
        if(error){
            res.send({ status: false, message: "Service created Failed"});
            console.log(" not ok"+error)
        } else {
          let sql5="INSERT INTO heure set ?"
        let details4 = {
          CinPersonnel:refCentre,
          refHoraire:3,
      };
      connection.query(sql5,details4,(error) => {
        if(error){
            res.send({ status: false, message: "Service created Failed"});
            console.log(" not ok"+error)
        } else {
          let sql5="INSERT INTO heure set ?"
        let details4 = {
          CinPersonnel:refCentre,
          refHoraire:4,
      };
      connection.query(sql5,details4,(error) => {
        if(error){
            res.send({ status: false, message: "Service created Failed"});
            console.log(" not ok"+error)
        } else {
          let sql5="INSERT INTO heure set ?"
        let details4 = {
          CinPersonnel:refCentre,
          refHoraire:5,
      };
      connection.query(sql5,details4,(error) => {
        if(error){
            res.send({ status: false, message: "Service created Failed"});
            console.log(" not ok"+error)
        } else {
          let sql5="INSERT INTO heure set ?"
        let details4 = {
          CinPersonnel:refCentre,
          refHoraire:6,
      };
      connection.query(sql5,details4,(error) => {
        if(error){
            res.send({ status: false, message: "Service created Failed"});
            console.log(" not ok"+error)
        } else {
          let sql5="INSERT INTO heure set ?"
        let details4 = {
          CinPersonnel:refCentre,
          refHoraire:7,
      };
      connection.query(sql5,details4,(error) => {
        if(error){
            res.send({ status: false, message: "Service created Failed"});
            console.log(" not ok"+error)
        } else {
          console.log("centre ajouter!!")
        }
      })
        }
      })
        }
      })
        }
      })
        }
      })
        }
      })
        }
      })
      
      })

      route.put("/api/UpdateHorairePerso/:reference", (req, res) => {
        const id = req.params.reference;
        const { ouvertureUpdate, fermetureUpdate, refselectedJourUpdate, CIN } = req.body;
        ov = "";
        f = "";
        refH = 0
        idCtr = null
        var sql = "SELECT * FROM heure WHERE reference=" + id;
        connection.query(sql, function (err, rows) {
          if (err) {
            console.error("Error executing query:1 " + err.stack);
            return;
          }
          if (ouvertureUpdate.length == 0) {
            ov = rows[0].ouverture
          } else {
            ov = ouvertureUpdate
          }
          if (fermetureUpdate.length === 0) {
            f = rows[0].fermeture
          } else {
            f = fermetureUpdate
          }
          if (refselectedJourUpdate.length === 0) {
            refH = rows[0].refHoraire
          } else {
            refH = refselectedJourUpdate
          }
          if (CIN.length === 0) {
            idCtr = rows[0].CinPersonnel
          } else {
            idCtr = CIN
          }
          const values = [ov, f, refH, idCtr];
          const sql = "UPDATE heure SET ouverture=?, fermeture=?, refHoraire=?, CinPersonnel=? WHERE reference=" + id;
          connection.query(sql, values, (err, rows) => {
            if (err) {
              console.log("Error executing query: " + err.stack);
              return;
            } else {
              console.log("Categorie Updated successfully")
            }
          });
        });
      });