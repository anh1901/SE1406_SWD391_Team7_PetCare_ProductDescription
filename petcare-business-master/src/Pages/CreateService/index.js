import React, { useState } from 'react';

import HeaderEditPage from '../../Components/HeaderEditPage';
import SideBar from '../../Components/SideBar';

import TitlePages from '../../Components/TitlePages';

import Input from '../../Components/Input';
import TextArea from '../../Components/TextArea';
import ButtonForm from '../../Components/ButtonForm';
import TransitionOfSetting from '../../Components/TransitionOfSetting';

import api from '../../Services/api';

import './styles.css';

export default function CreateService(props) {
  const INITIAL_STATE = {
    name: '',
    description: '',
    price: 0,
  }
  const [service, setService] = useState(INITIAL_STATE);
  const [errors, setErrors] = useState('');

  async function handleSubmit(e) {
    e.preventDefault();
    const { name, description, price } = service;
    if(!name || !price) {
    setErrors("Fill in all the data to register the product");
     } else {
       if(name.length <= 0 || name.length > 65) {
         setErrors("Service name too long");
        return;
      }

      if(description.length < 0 || description.length >= 650) {
        setErrors("Description can only be a maximum of 650 characters");
        return;
      }

      if(price <= 0 || price === 20000.00) {
        setErrors("Price is not valid");
        return;
      }

      await api.post("/create-service", service).then(() => {
        props.history.push('/services')
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
             return setErrors("The server is temporarily down");
           case "Request failed with status code 403":
             return setErrors("This name is already in use.");
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
        <HeaderEditPage requestsPage={true} />
        <div className="container-create-service">
          <TitlePages text="Service registration" />
          <form className="create-form-service" onSubmit={handleSubmit}>
            <TransitionOfSetting  errors={errors} title="Service" description="Service registration, note: register all services related to the pet shop here (Ex: Grooming, Bathing, Nursery, etc.)" />
            <div className="inputs">
              <Input type="text" placeholder="Service Name" onChange={e => setService({ ...service, name: e.target.value })}  messageBottom="Name of the service that will be visible to the user when choosing one for purchase." autoComplete="off" />
              <TextArea type="text" placeholder="Description." onChange={e => setService({ ...service, description: e.target.value })} />
              <Input type="number" placeholder="Price" onChange={e => setService({ ...service, price: e.target.value })} min="0" step="any" />
              <ButtonForm text="Create Service" />
            </div>
            <div className="bottom-border-settings" />
          </form>
        </div>
      </div>
    </>
  );
}
