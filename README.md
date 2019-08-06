# **MyHeroes**

## **Architecture**
### VIPER

Clear separation of concerns. Straighforward to create unit tests.<br/>
In the *Contract* we define all the interfaces they talk with each other.<br/>
Which happens in the following flow<br/>
*View* -> *Presenter* -> *Interactor* -> *Presenter* -> *View*<br/>
or<br/>
*View* -> *Presenter* -> *Router* -> *NextRouter*<br/>
*ViewModel* is a formatted representation of data the *View* consumes to draw itself on screen.

The project **(MyHeroes)** has a separate module holding the API Layer **(MyHeroesAPI)**.<br/>
This dependency is managed via cocoapods (private pod).<br/>
Apart from this dependency, there are only 3 other libraries **(SwiftLint, Quick and Nimble)**

Code coverage is 54% to the main project and 58% to the api project.<br/>
Due to short time, couldn't reach higher marks.

### Thank you 
Any questions, reach me @ gilson.gil@me.com<br/>
Gilson Gil
