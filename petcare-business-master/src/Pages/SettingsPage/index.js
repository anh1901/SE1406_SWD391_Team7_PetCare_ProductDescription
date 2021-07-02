import React, { useEffect, useState } from 'react';

import HeaderEditPage from '../../Components/HeaderEditPage';
import SideBar from '../../Components/SideBar';

import TitlePages from '../../Components/TitlePages';

import Input from '../../Components/Input';
import TextArea from '../../Components/TextArea';
import ButtonForm from '../../Components/ButtonForm';
import TransitionOfSetting from '../../Components/TransitionOfSetting';

import PetShopDogLogo from '../../Assets/PetShopDogLogo.svg';

import api from '../../Services/api';
import { isAuthenticated } from '../../Services/auth';

import './styles.css';

export default function SettingsPage(props) {
  const INITIAL_STATE = {
    cnpj: '',
    companyName: '',
    description: '',
    avatar: '',
    address: {
      placeNumber: 0,
      street: '',
      complement: '',
      neighborhood: '',
      city: '',
      state: '',
      cep: '',
    },
  }
  const [company, setCompany] = useState(INITIAL_STATE);
  const [errorsImage, setErrorsImage] = useState('');
  const [errors, setErrors] = useState('');

  useEffect(() => {
    if (isAuthenticated()) {
      loadCompany();
    } else {
      props.history.push('/login');
    }
  }, [props.history]);

  async function loadCompany() {
    await api.get("/profile-company").then(res => {
      setCompany(res.data);
    }).catch(error => {
      console.log(error);
    });
  }

  async function handleImage(e) {
     e.preventDefault();
     if(e.target.files[0] !== undefined && e.target.files[0].name !== null && (e.target.files[0].name.includes(".jpeg") || e.target.files[0].name.includes(".jpg") || e.target.files[0].name.includes(".png"))) {
       let data = new FormData();
       data.append('file', e.target.files[0]);
       await api.post(`/change-company-image/${company.id}`, data).then(() => {
         props.history.push('/settings');
         setErrorsImage("Image changed successfully.");
       });
     } else {
       setErrorsImage("Wrong image format.");
     }
   }

  async function handleSubmit(e) {
    e.preventDefault();

    const { cnpj, companyName, description } = company;
    const { street, placeNumber, complement, neighborhood, zip, city, state } = company.address;
    if (!cnpj || !companyName || !street || !placeNumber || !neighborhood || !zip || !city || !state) {
       setErrors("Fill all data to continue registration");
     } else {
       if (cnpj < 0 || cnpj.length > 18) {
         setErrors("CNPJ is invalid, please enter a correct one.");
         return;
       }

      if (companyName.length <= 0 || companyName.length > 250) {
        setErrors("Please enter a valid name");
        return;
      }

      if (description === null || description === undefined || description.length >= 350) {
        setErrors("Description too long.");
        return;
      }

      if (street === null || street === undefined || street.length > 250) {
        setErrors("Invalid street");
        return;
      }

      if (placeNumber === null || placeNumber === undefined || placeNumber < 0 || placeNumber > 20000) {
        setErrors("Invalid number");
        return;
      }

      if (complement === null || complement === undefined || complement.length >= 100) {
        setErrors("Add-on too long");
        return;
      }

      if (neighborhood === null || neighborhood === undefined || neighborhood.length > 250) {
        setErrors("Invalid neighborhood");
        return;
      }

      if (zip === null || zip === undefined || zip.length > 9) {
        setErrors("Invalid zip code");
        return;
      }

      if (state === null || state === undefined || state.length > 4) {
        setErrors("Invalid state");
        return;
      }

      await api.post(`/edit-company/${company.id}`, JSON.stringify(company)).then(() => {
        props.history.push('/login');
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
            return setErrors("The server is temporarily down");
          case "Request failed with status code 404":
            return setErrors("There is no company with this id.");
          case "Request failed with status code 403":
            return props.history.push("/login");
          default:
            return setErrors("");
        }
      });
    }
  }

  return (
    <>
      <SideBar props={props} />
      <div className="container-page-sidebar">
        <HeaderEditPage configuration={true} />
        <div className="container-settings">
          <TitlePages text="Settings" />
          <div className="forms-settings">
            <form className="form-image-settings" encType="multipart/form-data">
              <TransitionOfSetting errors={errorsImage} title="Avatar" description="This logo will be visible to anyone accessing this company." />
              <label htmlFor="input-image-company" >
                <img src={company.avatar ? (company.avatar) : (PetShopDogLogo)} alt="Company Logo" />
              </label>
              <input id="input-image-company" type="file" style={{ display: 'none' }} onChange={handleImage} enctyp="multipart/form-data" />
            </form>
            <form className="form-content-settings" onSubmit={handleSubmit}>
              <TransitionOfSetting errors={errors} title="Main" description="Information that will be used to show the user;" />
              <Input type="text" value={company.cnpj} onChange={e => setCompany({ ...company, cnpj: e.target.value })} placeholder="CNPJ" messageBottom="This CPNJ is which the company has been registered., but it cannot be changed" autoComplete="off" disabled={true} />
              <Input type="text" value={company.companyName} placeholder="Company Name" onChange={e => setCompany({ ...company, companyName: e.target.value })} messageBottom="This name will be visible to users who access the company page" autoComplete="off" />
              <div className="text-area-area">
                <TextArea value={company.description} placeholder="Description" onChange={e => setCompany({ ...company, description: e.target.value })} />
              </div>
              <Input type="text" value={company.address.street} placeholder="Address" onChange={e => setCompany({ ...company, address: { ...company.address, street: e.target.value } })} messageBottom="Address where the company was registered" autoComplete="off" />
              <Input type="number" value={company.address.placeNumber} placeholder="Number" onChange={e => setCompany({ ...company, address: { ...company.address, placeNumber: e.target.value } })} messageBottom="Property number" autoComplete="off" max="20000" />
              <Input type="text" value={company.address.complement} placeholder="Complement" onChange={e => setCompany({ ...company, address: { ...company.address, complement: e.target.value } })} messageBottom="Property complement" autoComplete="off" />
              <Input type="text" value={company.address.neighborhood} placeholder="Neighborhood" onChange={e => setCompany({ ...company, address: { ...company.address, neighborhood: e.target.value } })} autoComplete="off" />
              <Input type="text" value={company.address.cep} placeholder="ZIP" onChange={e => setCompany({ ...company, address: { ...company.address, cep: e.target.value } })} autoComplete="off" />
              <div className="city-states">
                <div className="city-input inputed">
                  <input type="text" value={company.address.city} placeholder="City" onChange={e => setCompany({ ...company, address: { ...company.address, city: e.target.value } })} />
                </div>
                <div className="states inputed">
                  <input type="text" value={company.address.state} placeholder="State" onChange={e => setCompany({ ...company, address: { ...company.address, state: e.target.value } })} />
                </div>
              </div>
              <ButtonForm text="Change company data" />
              <div className="bottom-border-settings" />
            </form>
          </div>
        </div>
      </div>
    </>
  );
}
