# TestTask
An application for displaying a list of people and detailed information about them from the [server](http://opn-interview-service.nn.r.appspot.com/). 

To obtain a token for working with server data, the following key is used
- An base64-encoded "$SECRET$" key
- The [JWT authorization bearer](https://jwt.io/) is HMAC 256 encoded based on the above key
- JWT payload that includes an object with two properties "uid" and "identity" with any values

## Libraries & Frameworks
- [SwiftJWT](https://github.com/Kitura/Swift-JWT) was used for JWT generation.
- [Alamofire](https://github.com/Alamofire/Alamofire) was used for network requests.
- [Combine](https://developer.apple.com/documentation/combine) was used for process the response results.

## Screenshot
<p float="left">
<img src="https://user-images.githubusercontent.com/68379006/192337064-6e4f6559-2fde-4658-bc76-04f18dbc337b.png" width="160" height="280">
<img src="https://user-images.githubusercontent.com/68379006/192337061-ff9ad9ac-4a53-401c-8a4a-f1886d01e494.png" width="160" height="280">
<img src="https://user-images.githubusercontent.com/68379006/192337058-45bd55c8-c117-4240-9d27-2fe43b270e18.png" width="160" height="280">
<img src="https://user-images.githubusercontent.com/68379006/192337054-573b3138-328e-44ab-ab90-11b3dab80a46.png" width="160" height="280">
</p>

## Video


https://user-images.githubusercontent.com/68379006/192512785-580a73ff-ced4-41c5-8110-d0505aa22fdc.mp4


