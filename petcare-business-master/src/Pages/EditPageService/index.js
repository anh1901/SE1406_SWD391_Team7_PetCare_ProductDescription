import React, { useEffect, useState } from 'react';

import HeaderEditPage from '../../Components/HeaderEditPage';
import SideBar from '../../Components/SideBar';
import Input from '../../Components/Input';
import TextArea from '../../Components/TextArea';
import ButtonForm from '../../Components/ButtonForm';

import api from '../../Services/api';
import { isAuthenticated } from '../../Services/auth';

import './styles.css';

export default function EditPageService(props) {
  const INITIAL_STATE = {
    id: '',
    name: '',
    description: '',
    price: '',
  }
  const [service, setService] = useState(INITIAL_STATE);
  const [errors, setErrors] = useState('');

  useEffect(() => {
    if (isAuthenticated()) {
      async function findProduct(id) {
        await api.get(`/services-list/${id}`).then(res => {
          setService(res.data);
        }).catch(error => {
          switch (error.message) {
            case "Network Error":
              return setErrors("The server is temporarily down");
            case "Request failed with status code 404":
              return setErrors("There is no service with this id.");
            case "Request failed with status code 403":
              return props.history.push("/login");
            default:
              return setErrors("");
          }
        });
      }
      if (props.match.params.id !== ":id") {
        findProduct(props.match.params.id);
      }
    } else {
      props.history.push('/login');
    }
  }, [props.history, props.match.params.id])

  async function handleSubmit(e) {
    e.preventDefault();
    const { name, description, price } = service;
    if (!name || !price) {
      setErrors("Fill in all necessary fields to change the service");
    } else {
      if (name === null || name === undefined || name.length > 65) {
        setErrors("Product name too long");
        return;
      }

      if (description === null || description === undefined || description.length >= 650) {
        setErrors("Description can only be a maximum of 650 characters");
        return;
      }

      if (price === null || price === undefined || price === 20000.00) {
        setErrors("Price is not valid");
        return;
      }

      await api.post(`/edit-service/${service.id}`, service).then(() => {
        props.history.push('/services');
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
            return setErrors("The server is temporarily down");
          case "Request failed with status code 404":
            return setErrors("There is no product with this id.");
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
        <HeaderEditPage services={true} />
        <div className="container-form-edit-service">
          <div className="product-info-edit-title">
            Edit service data
          </div>
          <span className="errors-span">{errors}</span>
          <form className="service-edit-form" onSubmit={handleSubmit}>
            <Input type="text" value={service.name} placeholder="Service name" onChange={e => setService({ ...service, name: e.target.value })} messageBottom="Name of the service that will be visible to the user when choosing one to purchase." />
            <TextArea placeholder="Description" value={service.description} onChange={e => setService({ ...service, description: e.target.value })} />
            <Input type="number" value={service.price} placeholder="Price" onChange={e => setService({ ...service, price: e.target.value })} messageBottom="Use point for cents." />
            <ButtonForm text="Confirm Change" />
          </form>
        </div>
      </div>
    </>
  );
}