# Hamosad Scouting App 2

### A scouting app for the FRC team Hamosad 1657.

### Version 2.

</br>

## <u>Use</u>
The intention of this app is to gather information about teams annd robots in an FRC competition.  
This type of information gathering is often reffered to as **Scouting**.

**Steps to use the app:**
1. Make a schema for the app (see [Schema](#schema)).
2. Connect it to a Firebase database (see [Connecting to Firebase](#connecting-to-firebase)).
3. Build the app (see [Build](#build)).
4. Host it on a website (for example, using [Cloudflare](https://www.cloudflare.com/)).
5. Start scouting!

</br>

## <u>Schema</u>
The main feature of this version of the app, is the schema.   
A schema is a JSON file that defines the structure of the app, and the data that will be stored in the database.

To define a custom schema, do the following:
1. Clone this repository.
2. Open the file `scouting.json` (located in `./schema/`) in [Visual Studio Code](https://code.visualstudio.com/).
3. Change it to match this year's game.

An example strucutre of a schema:

```json
{
	"$schema": "./schemas/app.schema.json",
	"name": "Scouting App",
	"teamNumber": 1657,
	"pages": {
		"home": {
			"title": "Scouting App",
			"widgets": {
				"name": {
					"type": "textInput",
					"hint": "Enter your name..."
				},
			}
		},
	},
	"reports": {
		"game": {
			"description": "Game Report",
			"pages": {
				"teleop": {
					"title": "Teleop",
					"icon": "people",
					"widgets": {
						"ballsPickedFloor": {
							"type": "counter",
							"title": "Balls picked from the floor",
							"min": 0,
							"max": 999,
							"step": 1
						},
						"ballsUpper": {
							"type": "counter",
							"title": "Balls entered upper hub",
							"min": 0,
							"max": 999,
							"step": 1,
							"score": 2
						},
					}
				}
			}
		}
	}
}
```

This will create an app with the following structure:
- A main page with a text input widget telling the user to input their name.
- A game report type with one page (a Teleop page), with two counter widgets:
	- Balls picked from the floor
	- Balls entered upper hub

Using this schema, you can create a structure that matches the current year's game, with widgets to gather information about robots and teams.

The structure of the schema is described below. The indetation indicates the structure of the JSON (indented lines are inside the object that was defined in the line above them).

Lines that start with a * marks an optional field.

*Note: When using Visual Studio Code, the files in ./schema/schemas/ will enforce this structure with Intellisense and warnings.*

</br>

- The line `"$schema": "./schemas/app.schema.json"`.
- A `name` field with the apps name. This name will be used as the webpage name.
- A `teamNumber` field with your team number.
- A `pages` field with a list of the app'ss pages that are not part of the reports. This can include a home page, an about page etc.
	- A `home` field with the structure of the home page.
		- A `title` field with the title of the page.
		- \* A `logo` field containing the path to an image that will be displayed in the top of the page.
		- \* A `widgets` field with a list of widgets to be displayed in the page.
	- \* More fields describing additional pages.
		- A `title` field with the title of the page.
		- \* An `icon` field containing the path to an image that will be displayed in the main page, and will be used to navigate to this page.
