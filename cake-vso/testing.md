## 1. Pre-requisites

1. Clone repository
1. Make sure you have a VSTS account.
1. Create a new personal publisher
   * Go to https://marketplace.visualstudio.com/manage/publishers/cake-build
   * Click the `Cake Build` dropdown and select `Create new publisher`

## 2. Preparations in repository

### 2.1. Change properties in `extension-manifest.json`

* `public` to false
* `publisher` to your publisher name

### 2.2. Change properties in Task/task.json

* `id` should be replaced with a new GUID.

## 3. Upload extension for testing

1. Package the plugin
  - `tfx extension create --manifest-globs .\extension-manifest.json`
1. Log into the VSTS Marketplace
1. Hover over the Cake VSTS extension and select Update
1. Browse to the VSIX file that was generated above
1. Click Upload

## 4. Test the extension

1. Create a VSTS project
1. Go to `https://marketplace.visualstudio.com/items?itemName=mypublisher.cake`
   * Where `mypublisher` is the name of your publisher.
1. Click `Install`
1. In the popup, select your personal account (not `Cake Build`).
1. Click Confirm
1. The extension should be available to use for the account that you specified.

