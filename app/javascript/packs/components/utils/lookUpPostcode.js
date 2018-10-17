import PostcodesIO from 'postcodesio-client'

const lookUpPostcode = (postcode, callback) => {
  console.log(postcode)
  const postcodes = new PostcodesIO();
  postcodes.lookup(postcode).then(postcode => {
    callback(postcode.latitude, postcode.longitude);
  }).catch(
    () => console.log('unable to recognise postcode')
  )
}

export default lookUpPostcode
