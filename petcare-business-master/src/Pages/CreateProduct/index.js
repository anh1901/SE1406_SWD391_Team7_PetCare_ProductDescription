import React, { useState } from 'react';

import HeaderEditPage from '../../Components/HeaderEditPage';
import SideBar from '../../Components/SideBar';

import TitlePages from '../../Components/TitlePages';

import Input from '../../Components/Input';
import InputFileImage from '../../Components/InputFileImage';
import TextArea from '../../Components/TextArea';
import ButtonForm from '../../Components/ButtonForm';
import TransitionOfSetting from '../../Components/TransitionOfSetting';

import api from '../../Services/api';

import './styles.css';

export default function CreateProduct(props) {
  const INITIAL_STATE = {
    avatar: '',
    name: '',
    description: '',
    price: 0,
    weight: 0,
    indicationPet: '',
    porte: '',
    age: '',
    transgenic: '',
    composition: '',
    quantityStore: 0,
  }
  const [product, setProduct] = useState(INITIAL_STATE);
  const [errors, setErrors] = useState('');
  const [textImage, setTextImage] = useState('');

  function handleImage(e) {
    e.preventDefault();
    setProduct({ ...product, avatar: e.target.files[0] });
    setTextImage(e.target.files[0].name);
  }

  async function handleSubmit(e) {
    e.preventDefault();
    const { name, description, price, indicationPet, porte, age, composition, quantityStore } = product;
    if(!name || !price || !indicationPet || !porte || !age || !quantityStore) {
      setErrors("Fill in all data to register the product");
    } else {
      if(name.length <= 0 || name.length > 65) {
        setErrors("Product name too long");
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

      if(quantityStore <= 0 || quantityStore > 5000) {
        setErrors("Invalid Stock Quantity");
        return;
      }

      if(indicationPet.length <= 0 || indicationPet.length >= 100) {
        setErrors("Very extensive indication");
        return;
      }

      if(porte.length <= 0 || porte.length >= 50) {
        setErrors("Very large size");
        return;
      }

      if(age.length <= 0 || age.length >= 35) {
        setErrors("Very old age");
        return;
      }

      if(composition.length <= 0 || composition.length >= 650) {
        setErrors("Very extensive composition");
        return;
      }

      let data = new FormData();
      data.append('name', product.name)
      data.append('description', product.description)
      data.append('price', product.price)
      data.append('weight', product.weight)
      data.append('indicationPet', product.indicationPet)
      data.append('porte', product.porte)
      data.append('age', product.age)
      data.append('transgenic', product.transgenic)
      data.append('composition', product.composition)
      data.append('quantityStore', product.quantityStore)
      data.append('file', product.avatar)

      await api.post("/create-product", data).then(() => {
        props.history.push('/produtos')
      }).catch(error => {
        switch (error.message) {
          case "Network Error":
            return setErrors("The server is temporarily turned off");
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
        <HeaderEditPage editPage={true} />
        <div className="container-create-product">
          <TitlePages text="Product registration" />
          <form className="create-form-product" onSubmit={handleSubmit} encType="multipart/form-data">
            <TransitionOfSetting title="Product image" description="An image of the product must be inserted here. Just click and select the desired image." />
            <InputFileImage onChangeText={textImage} onChange={handleImage} />
            <TransitionOfSetting errors={errors} title="Product information" description="Product registration, this product will be visible to the user on the company's profile page for purchase." />
            <div className="inputs">
              <Input type="text" placeholder="Product's name" onChange={e => setProduct({ ...product, name: e.target.value })} messageBottom="Name of the service that will be visible to the user when choosing one for purchase." autoComplete="off" />
              <TextArea type="text" value={product.description} placeholder="Description. (Optional)" onChange={e => setProduct({ ...product, description: e.target.value })} />
              <Input type="number" placeholder="Price" onChange={e => setProduct({ ...product, price: e.target.value })} min="0" step="any" />
              <Input type="number" placeholder="Quantity in stock" onChange={e => setProduct({ ...product, quantityStore: e.target.value })} min="0" step="no" messageBottom="Number of items that will go into stock" />
              <Input type="text" placeholder="Weight" onChange={e => setProduct({ ...product, weight: e.target.value })} messageBottom="It is necessary to put the unit of the weight of the product. Ex 150g or 15kg" autoComplete="off" />
              <Input type="text" placeholder="Recommendation" onChange={e => setProduct({ ...product, indicationPet: e.target.value })} messageBottom="For whom this product is indicated. Ex Dog, Cat..." autoComplete="off" />
              <Input type="text" placeholder="Postage" onChange={e => setProduct({ ...product, porte: e.target.value })} messageBottom="What is the size of the animal. E.g. Small, Medium or Large" autoComplete="off" />
              <Input type="text" placeholder="Age" onChange={e => setProduct({ ...product, age: e.target.value })} messageBottom="Pup, Adult, Elderly..." autoComplete="off" />
              <Input type="text" placeholder="Transgenic" onChange={e => setProduct({ ...product, transgenic: e.target.value })} messageBottom="Does the product have transgenics? E.g. Yes, No" autoComplete="off" />
              <TextArea type="text" value={product.composition} placeholder="Composition." onChange={e => setProduct({ ...product, composition: e.target.value })} />
              <ButtonForm text="Create Product" />
            </div>
            <div className="bottom-border-settings" />
          </form>
        </div>
      </div>
    </>
  );
}