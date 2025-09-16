import { useState, useEffect, React } from 'react';
import axios from 'axios';
import { Buffer } from 'buffer';
import Iconify from "../components/iconify";
import { useLocation } from "react-router-dom";

import {
  Container,
  Typography,
  IconButton,
  Grid,
  Card,
  Stack,
  Button,
  TextField,
  Select, MenuItem, InputLabel
} from '@mui/material';
import { makeStyles } from '@material-ui/core/styles';
import Avatar from '@material-ui/core/Avatar';
import { blueGrey } from '@material-ui/core/colors';

const useStyles = makeStyles((theme) => ({
  root: {
    minHeight: '100vh',
    backgroundColor: '#9de2ff',
  },
  card: {
    borderRadius: '15px',
    display: 'flex',
    flexDirection: 'row',
    margin: '5% auto',
    maxWidth: '600px',
  },
  media: {
    borderRadius: '10px',
    flex: 1,
    height: 0,
    paddingTop: '56.25%', // 16:9
  },
  details: {
    display: 'flex',
    flexDirection: 'column',
    flex: 2,
    padding: theme.spacing(3),
  },
  avatar: {
    backgroundColor: blueGrey[500],
    width: '72px',
    height: '72px',
    borderRadius: '50%',
    margin: 'auto',
    marginBottom: theme.spacing(3),
  },
  stats: {
    backgroundColor: '#efefef',
    borderRadius: '10px',
    display: 'flex',
    justifyContent: 'space-around',
    padding: theme.spacing(1),
    margin: theme.spacing(2, 0),
  },
  buttonGroup: {
    display: 'flex',
    flex: 1,
    justifyContent: 'space-around',
    margin: theme.spacing(2, 0),
  },
}));

export default function PersoProfile() {
  const classes = useStyles();
  const location = useLocation();
  const CINPerso = location.pathname.split("/")[2];
  // State variables
  const [selectedPerso, setSelectedPerso] = useState([]);

  useEffect(() => {
    // Fetch data from API and update state variables
    axios.get(`http://localhost:5000/api/getOnepersonnel/${CINPerso}`)
      .then(res => setSelectedPerso(res.data));
  }, [CINPerso]);

  const [isOpenPopNomP, setIsOpenPopNomP] = useState(false);
  const [isOpenPopTel, setIsOpenPopTel] = useState(false);
  const [isOpenPopSexe, setIsOpenPopSexe] = useState(false);
  const [isOpenPopMdp, setIsOpenPopMdp] = useState(false);
  const [isOpenPopImg, setIsOpenPopImg] = useState(false);
  const [nom, setNom] = useState("");
  const [prenom, setPrenom] = useState("");
  const [sexe, setSexe] = useState("");
  const [tel, setTel] = useState();
  const [mdpact, setMdpAct] = useState("");
  const [mdpNovCon, setMdpNovCon] = useState("");
  const [mdp, setMdp] = useState("");
  const [img, setImg] = useState();
  const [imgBD, setImgBD] = useState();
  const togglePopupNomP = () => {
		setIsOpenPopNomP(!isOpenPopNomP);
		document.body.style.overflow = "auto";
	};
  const togglePopupTel = () => {
		setIsOpenPopTel(!isOpenPopTel);
		document.body.style.overflow = "auto";
	};
  const togglePopupSexe = () => {
		setIsOpenPopSexe(!isOpenPopSexe);
		document.body.style.overflow = "auto";
	};
  const togglePopupMdp = () => {
		setIsOpenPopMdp(!isOpenPopMdp);
		document.body.style.overflow = "auto";
	};
  const togglePopupImg = () => {
		setIsOpenPopImg(!isOpenPopImg);
		document.body.style.overflow = "auto";
	};
  const [errMessageNom, setErrMessageNom]=useState('');
    const [errorNom, setErrorNom] = useState(false);
    const [messageNom, setMessageNom]=useState(false);

    const nomValidation=(e)=>{
      const pattern = /^[^@.,;:/\\<>[\]{}()|^=_+*&%$#!?¨`~¤£§€°æøåÆØÅ\d]{3,}$/
      const nomValue=e.target.value
      setNom(nomValue)
      if(nomValue===''){
        setMessageNom(true)
      }else {
        if(nom.match(pattern)){
          setMessageNom(true)
        }else {
          setMessageNom(false)
        }
        }
    }
    
    const [errMessagePrenom, setErrMessagePrenom]=useState('');
    const [errorPrenom, setErrorPrenom] = useState(false);
    const [messagePrenom, setMessagePrenom]=useState(false);

    const prenomValidation=(e)=>{
      const pattern = /^[^@.,;:/\\<>[\]{}()|^=_+*&%$#!?¨`~¤£§€°æøåÆØÅ\d]{3,}$/
      const nomValue=e.target.value
      setPrenom(nomValue)
      if(nomValue===''){
        setMessagePrenom(true)
      }else {
        if(prenom.match(pattern)){
          setMessagePrenom(true)
        }else {
          setMessagePrenom(false)
        }
        }
    }
    

    const [errMessageTel, setErrMessageTel]=useState('');
    const [errorTel, setErrorTel] = useState(false);
    const [messageTel, setMessageTel]=useState(false);

    const telValidation = (e) => {
      const pattern = /^\d{8}$/;
      const telValue = e.target.value;
      setTel(telValue);
      if (telValue.match(pattern)) {
        setMessageTel(true);
      } else {
        setMessageTel(false);
      }
    };

    const [errMessageMdpAct, setErrMessageMdpAct]=useState('');
    const [errorAct, setErrorAct] = useState(false);

    const [errMessageMdpNov, setErrMessageMdpNov]=useState('');
    const [errorMdpNov, setErrorMdpNov] = useState(false);
    const [messageMdpNov, setMessageMdpNov]=useState(false);

    const [errMessageMdpNovCon, setErrMessageMdpNovCon]=useState('');
    const [errorMdpNovCon, setErrorMdpNovCon] = useState(false);

    const mdpValidation = (e) => {
      const pattern = /^[0-9a-zA-Z\.\-\+\*\/\$=]{8,}$/;
      const mdpValue = e.target.value;
      setMdp(mdpValue);
      if (mdpValue.match(pattern)) {
        setMessageMdpNov(true);
      } else {
        setMessageMdpNov(false);
      }
    };

    const [errMessageSexe, setErrMessageSexe]=useState('');
    const [errorSexe, setErrorSexe] = useState(false);

    const [test1, setTest1] = useState(true);
    const [test2, setTest2] = useState(true);
    const [test3, setTest3] = useState(true);
    const [test4, setTest4] = useState(true);
    const [test5, setTest5] = useState(true);
    const [test6, setTest6] = useState(true);
    const [test7, setTest7] = useState(true);
    const [test8, setTest8] = useState(true);

    const [errMessageImg, setErrMessageImg]=useState('');
    const [errorImg, setErrorImg] = useState(false);
    const [messageImg, setMessageImg]=useState(false);

    const imgValidation = (e) => {
      const im = e.target.files[0];
      console.log(im)
      const imgValue = e.target.value;
      setImg(imgValue);
      setImgBD(im)
    
      if (im==="") {
        setMessageImg(false);
      } else {
        setMessageImg(true);
      }
    };

    function onUpdateNP(nom,prenom) {
      if(nom===''){
        setErrorNom(true)
        setErrMessageNom('Le champ est obligatoire.')
        console.log(errorNom)
      }else
      if(!messageNom){
        setErrorNom(true)
        setErrMessageNom('Le champ est invalid.')
      }else{
        setErrorNom(false)
        setErrMessageNom('')
        setTest1(false)
      }

      if(prenom===''){
        setErrorPrenom(true)
        setErrMessagePrenom('Le champ est obligatoire.')
        console.log(errorPrenom)
      }else
      if(!messagePrenom){
        setErrorPrenom(true)
        setErrMessagePrenom('Le champ est invalid.')
      }else{
        setErrorPrenom(false)
        setErrMessagePrenom('')
        setTest2(false)
      }
      if(!test1 && !test2){
        window.location.reload();
      axios.put(`http://localhost:5000/api/updateNomPrenom/${CINPerso}`, {
        nom
        , prenom
      });
      console.log("Nom Penom updated");
    }
    }
    function onUpdateSexe(sexe) {
      if(sexe.length===0){
        setErrorSexe(true)
        setErrMessageSexe('Le champ est obligatoire.')
      }else{
        setErrorSexe(false)
        setErrMessageSexe('')
        setTest3(false)
      }
      if(!test3){
        window.location.reload();
      axios.put(`http://localhost:5000/api/updateSexe/${CINPerso}`, {
        sexe
      });
      console.log("Nom Penom updated");
    }
    }
    function onUpdateTel(tel) {
      if(tel===0){
        setErrorTel(true)
        setErrMessageTel('Le champ est obligatoire.')
      }else
      if(!messageTel){
        setErrorTel(true)
        setErrMessageTel('Le champ est invalid.')
      }else {
        setErrorTel(false)
        setErrMessageTel('')
        setTest4(false)
      }
      if(!test4){
        window.location.reload();
      axios.put(`http://localhost:5000/api/updateTel/${CINPerso}`, {
        tel
      });
      console.log("Nom Penom updated");
    }
    }

    function onUpdateMdp(mdp) {
      if(mdp===''){
        setErrorMdpNov(true)
        setErrMessageMdpNov('Le champ est obligatoire.')
        console.log(errorNom)
      }else
      if(mdp.length<8){
        setErrorMdpNov(true)
        setErrMessageMdpNov('Mot de passe doit contenir au moins 8 caractères')
        console.log(errorNom)
      }else
      if(!messageMdpNov){
        setErrorMdpNov(true)
        setErrMessageMdpNov('Le champ est invalid.')
      }else{
        setErrorMdpNov(false)
        setErrMessageMdpNov('')
        setTest5(false)
      }
      const getPass=selectedPerso[0].password;
      console.log(getPass!==mdpact)
      if(mdpact===''){
        setErrorAct(true)
        setErrMessageMdpAct('Le champ est obligatoire.')
      }else
      if(getPass!==mdpact){
        setErrorAct(true)
        setErrMessageMdpAct('Le champ est invalid.')
      }else{
        setErrorAct(false)
        setErrMessageMdpAct('')
        setTest6(false)
      }
      if(mdpNovCon===''){
        setErrorMdpNovCon(true)
        setErrMessageMdpNovCon('Le champ est obligatoire.')
      }else
      if(mdpNovCon!==mdp){
        setErrorMdpNovCon(true)
        setErrMessageMdpNovCon('Le champ est invalid.')
      }else{
        setErrorMdpNovCon(false)
        setErrMessageMdpNovCon('')
        setTest7(false)
      }
      if(!test5 && !test6 && !test7){
        window.location.reload();
      axios.put(`http://localhost:5000/api/updateMdp/${CINPerso}`, {
        mdp
      });
      console.log("Nom Penom updated");
    }
    }
    function onUpdateImg(imgBD) {
      if(imgBD===""){
        setErrorImg(true)
        setErrMessageImg('Le champ est obligatoire.')
      }else
      if(!messageImg){
        setErrorImg(true)
        setErrMessageImg('Le champ est invalid.')
      }else {
        setErrorImg(false)
        setErrMessageImg('')
        setTest8(false)
      }
      const formData = new FormData();
    formData.append('image', imgBD);
      if(!test8){
        window.location.reload();
      axios.put(`http://localhost:5000/api/updateImg/${CINPerso}`,formData);
      console.log("Nom Penom updated");
    }
    }

  const nbPass = (pass) => {
    let ch = "";
    for (let i = 0; i < pass.length; i++) {
      ch = ch + "*";
    }
    return ch;
  }

  return (
    <>
    <Container>
      <Stack spacing={3}>
        <Grid container spacing={3}>
          {selectedPerso.map((row, index) => (
            <Grid item xs={12} md={8} lg={12} key={index}>
              <Card className={classes.card}>
                <div className={classes.details}>
                  <div style={{ display: "flex", alignItems: "center" }}>
                    <Avatar
                      style={{ backgroundColor: 'white' }}
                      alt="Danny McLoan"
                      src={row.photo && `data:image/png;base64,${Buffer.from(row.photo.data).toString('base64')}`}
                      sx={{ width: 48, height: 48, borderRadius: 1.5, flexShrink: 0 }}
                      className={classes.avatar}
                      onClick={togglePopupImg}
                    />
                  </div>
                  <div style={{ display: "flex", alignItems: "center", justifyContent: "center" }}>
                    <Typography variant="h5" component="h2" align="center" onClick={togglePopupNomP}>
                      {row.nom} {row.prenom}<br/>
                      {row.email}
                    </Typography>
                    
                  </div>
                  <div className={classes.stats}>
                    <div>
                      <div style={{ display: "flex", alignItems: "center",}}>
                        <Typography variant="h6"></Typography>
                      </div>
                      <br />
                      <div style={{ display: "flex", alignItems: "center",}}>
                        <Typography variant="body2" color="textSecondary">
                          Telephone :
                        </Typography>
                        <Typography variant="h6 "onClick={togglePopupTel}>{row.tel}</Typography>
                      </div>
                      <div style={{ display: "flex", alignItems: "center"}}>
                        <Typography variant="body2" color="textSecondary">
                          Sexe :
                        </Typography>
                        <Typography variant="h6" onClick={togglePopupSexe}>{row.sexe}</Typography>
                      </div>
                      <div style={{ display: "flex", alignItems: "center"}}>
                        <Typography variant="body2" color="textSecondary">
                          Mot de passe :
                        </Typography>
                        <Typography variant="h6" onClick={togglePopupMdp}>{nbPass(row.password)}</Typography>
                      </div>
                    </div>
                    <br />
                  </div>
                </div>
              </Card>
            </Grid>
          ))}
        </Grid>
      </Stack>
    </Container>

{isOpenPopNomP && (
            <div className="popup-overlay">
              <div className="popup">
                <Button variant="contained"
                sx={{
                    backgroundColor: "success.main",
                  }}
                 onClick={() => {
                setIsOpenPopNomP(!isOpenPopNomP);
                document.body.style.overflow = "auto";
              }}>
                  X
                </Button>
                <br/>
                <Stack spacing={3}>
                <h2> Changer nom et prénom</h2>
                  <TextField
                    name="nom"
                    label="Nom"
                    value={nom}
                    onChange={nomValidation}
                    error={errorNom}
                    helperText={errorNom ? errMessageNom : ''}
                  />
                  <TextField
                    name="prenom"
                    label="Prénom"
                    onChange={prenomValidation}
                    error={errorPrenom}
                    helperText={errorPrenom ? errMessagePrenom : ''}
                  />
                  
                </Stack>
                <br />
                <Button
                  type="submit"
                  sx={{
                    backgroundColor: "success.main",
                  }}
                  align="centre"
                  variant="contained"
                  onClick={() =>
                    onUpdateNP( nom, prenom)
                  }
                >
                  Mise à jour
                </Button>
              </div>
            </div>
          )}
{isOpenPopTel && (
            <div className="popup-overlay">
              <div className="popup">
                <Button variant="contained"
                sx={{
                    backgroundColor: "success.main",
                  }}
                 onClick={() => {
                setIsOpenPopTel(!isOpenPopTel);
                document.body.style.overflow = "auto";
              }}>
                  X
                </Button>
                <h2> Changer le numéro de Téléphone</h2>
                <Stack spacing={3}>
                  
                  <TextField
                    name="tel"
                    label="Téléphone"
                    value={tel}
                    type="number"
                    onChange={telValidation}
                    error={errorTel}
                    helperText={errorTel ? errMessageTel : ''}
                  />
                  
                </Stack>
                <br />
                <Button
                  type="submit"
                  sx={{
                    backgroundColor: "success.main",
                  }}
                  align="centre"
                  variant="contained"
                  onClick={() =>
                    onUpdateTel( tel)
                  }
                >
                  Mise à jour
                </Button>
              </div>
            </div>
          )}
{isOpenPopSexe && (
            <div className="popup-overlay">
              <div className="popup">
                <Button variant="contained"
                sx={{
                    backgroundColor: "success.main",
                  }}
                 onClick={() => {
                setIsOpenPopSexe(!isOpenPopSexe);
                document.body.style.overflow = "auto";
              }}>
                  X
                </Button>
                <h2> Changer sexe</h2>
                <Stack spacing={3}>
                  
                <InputLabel id="my-select-label">Sexe</InputLabel>
                  <Select
                    labelId="my-select-label"
                    value={sexe}
                    onChange={(event) => {
                        setSexe(event.target.value);
                      }}
                      error={errorSexe}
                    >
                    <MenuItem key="Femme" value="Femme">
                    Femme
                    </MenuItem>
                    <MenuItem key="Homme" value="Homme">
                    Homme
                    </MenuItem>
                    </Select>
                    {errorSexe? <span className="err">{errMessageSexe}</span>:''}
                </Stack>
                <br />
                <Button
                  type="submit"
                  sx={{
                    backgroundColor: "success.main",
                  }}
                  align="centre"
                  variant="contained"
                  onClick={() =>
                    onUpdateSexe( sexe)
                  }
                >
                  Mise à jour
                </Button>
              </div>
            </div>
          )}
{isOpenPopMdp && (
            <div className="popup-overlay">
              <div className="popup">
                <Button variant="contained"
                sx={{
                    backgroundColor: "success.main",
                  }}
                 onClick={() => {
                setIsOpenPopMdp(!isOpenPopMdp);
                document.body.style.overflow = "auto";
              }}>
                  X
                </Button>
                <h2> Changer de mot de passe</h2>
                <p>Votre mot de passe doit contenir au moins 8 caractères ainsi qu’une combinaison de chiffres, de lettres et de caractères spéciaux ( !$@%).</p>
                <Stack spacing={3}>
                  <TextField
                    name="mdp"
                    label="Mot de passe actuel"
                    type="password"
                    value={mdpact}
                    onChange={(e) => {
                      setMdpAct(e.target.value);
                    }}
                    error={errorAct}
                    helperText={errorAct ? errMessageMdpAct : ''}
                  />
                  <TextField
                    name="nMdp"
                    type="password"
                    label="Nouveau mot de passe"
                    onChange={mdpValidation}
                    error={errorMdpNov}
                    helperText={errorMdpNov ? errMessageMdpNov : ''}
                  />
                  <TextField
                    name="nrMdp"
                    type="password"
                    label="Retapez le nouveau mot de passe"
                    onChange={(e) => {
                      setMdpNovCon(e.target.value);
                    }}
                    error={errorMdpNovCon}
                    helperText={errorMdpNovCon ? errMessageMdpNovCon : ''}
                  />
                  
                </Stack>
                <br />
                <Button
                  type="submit"
                  sx={{
                    backgroundColor: "success.main",
                  }}
                  align="centre"
                  variant="contained"
                  onClick={() =>
                    onUpdateMdp( mdp)
                  }
                >
                  Mise à jour
                </Button>
              </div>
            </div>
          )}
{isOpenPopImg && (
            <div className="popup-overlay">
              <div className="popup">
                <Button variant="contained"
                sx={{
                    backgroundColor: "success.main",
                  }}
                 onClick={() => {
                setIsOpenPopImg(!isOpenPopImg);
                document.body.style.overflow = "auto";
              }}>
                  X
                </Button>
                <h2> Changer photo de profile</h2>
                <Stack spacing={3}>
                  <TextField
                    name="photo"
                    type="file"
                    value={img}
                    onChange={imgValidation}
                    error={errorImg}
                    helperText={errorImg ? errMessageImg : ''}
                  />
                  
                </Stack>
                <br />
                <Button
                  type="submit"
                  sx={{
                    backgroundColor: "success.main",
                  }}
                  align="centre"
                  variant="contained"
                  onClick={() =>
                    onUpdateImg( imgBD)
                  }
                >
                  Mise à jour
                </Button>
              </div>
            </div>
          )}

    </>
  );
}
