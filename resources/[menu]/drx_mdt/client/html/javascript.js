const drx_mdt = new Vue({
    el: '#DRX_MDT',
    vuetify: new Vuetify(),

    data: () => ({
        // CONFIGS
        Fines: [
           { id: 1, label: 'Shooting', amount: 500, time: 5, desc: 'the action or practice of shooting with a gun.' },
            { id: 2, label: 'Robbery', amount: 501, time: 10, desc: 'the act of robbing—stealing, especially by force or through threats of violence.' },
            { id: 3, label: 'Illegal possesion of firearms', amount: 502, time: 15, desc: 'illegal possession of a firearm is, in the simplest term, unlawful possession of a certain weapon on behalf of an individual.' },
            { id: 4, label: 'Resisting arrest', amount: 503, time: 20, desc: 'occurs when a person interferes with a law enforcement officers attempt to perform a lawful arrest.' },
            { id: 5, label: 'Obstruction of justice', amount: 504, time: 25, desc: 'is a crime consisting of obstructing prosecutors, investigators, or other government officials. Common law jurisdictions other than the United States tend to use the wider offense of perverting the course of justice.' },
            { id: 6, label: 'Theft', amount: 505, time: 30, desc: 'the action or crime of stealing.' },
            { id: 7, label: 'Grave threat', amount: 506, time: 35, desc: ' often made anonymously, by one person or a group of people to kill another person or group of people. These threats are often designed to intimidate victims in order to manipulate their behaviour, in which case a death threat could be a form of coercion.' },
            { id: 8, label: 'Kidnapping', amount: 507, time: 40, desc: 'criminal offense consisting of the unlawful taking and carrying away of a person by force or fraud or the unlawful seizure and detention of a person against his will' },
            { id: 9, label: 'Attempted murder', amount: 508, time: 45, desc: 'a crime of attempt in various jurisdictions.' },
            { id: 10, label: 'Murder', amount: 509, time: 50, desc: 'the unlawful premeditated killing of one human being by another.' },
            { id: 11, label: 'Driving without License', amount: 510, time: 55, desc: 'Driving Without a valid license'},
            { id: 13, label: 'Drug Trafficking', amount: 512, time: 65, desc: 'also known as drug distribution, is the crime of selling, transporting, or illegally importing unlawful controlled substances, such as heroin, cocaine, marijuana, or other illegal drugs.' },
			{ id: 14, label: 'Disrespecting An police Officer', amount: 513, time: 70, desc: 'Disrespecting behavior towards a police officer.' },
			{ id: 15, label: 'Extortion', amount: 514, time: 75, desc: 'the practice of obtaining something, especially money, through force or threats' },
			{ id: 16, label: 'Tampering of Evidence', amount: 515, time: 80, desc: 'act in which a person alters, conceals, falsifies, or destroys evidence with the intent to interfere with an investigation' },

        ],

        WarrantsPerson: [
           { id: 1, label: 'Warrant Of Arrest' },
            { id: 2, label: 'Search Warrant' },
            { id: 3, label: 'Capias Warrant/Pro Fine Warrant' },
            { id: 4, label: 'Fugitive Warrant' },
        ],

        WarrantsVehicle: [
           { id: 1, label: 'Search Warrant' },
           { id: 2, label: 'Reckless Driving' },
		   { id: 3, label: 'Used in Robbery' },
		   { id: 4, label: 'Used in Kidnapping' },
		   { id: 5, label: 'Used in Illegal Activity' },
		   { id: 6, label: 'Get Away Vehicle' },
        ],

        // DO NOT CHANGE ANYTHING UNDER THIS LINE, UNLESS YOU KNOW WHAT YOU ARE DOING!



        // Basic
        isOpen: false,
        imageChange: false,
        zimageChange: 0,
        managementChange: false,
        zmanagementChange: 0,

        // Pages
        currentPage: 'HOME',
        MainPages: ['HOME', 'CRIMINAL RECORD', 'SEARCH VEHICLES', 'DISPATCH', 'WARRANTS', 'FINES', 'PROFILE'],

        // drx_mdt_profiles
        drxProfiles: [],
        identifier: undefined,
        rank: '',
        charname: '',
        policegroup: '',
        badgenumber: '',
        duty: '',
        image: '',

        // users
        identifier: undefined,
        vrpcharname: '',
        phone_number: '',
        dateofbirth: '',

        // Management Overlay
        identifierData: undefined,
        rankData: '',
        charnameData: '',
        policegroupData: '',
        badgenumberData: '',
        dutyData: '',
        imageData: '',

        // Criminal Records
        changeNote: false,
        zchangeNote: 0,
        showLicenses: false,
        zshowLicenses: 0,
        changeCharges: false,
        zchangeCharges: 0,
        newCharges: false,
        znewCharges: 0,
        showCharges: false,
        zshowCharges: 0,
        searchResults: {},
        searchInput: '',
        UserLicenses: {},
        selectedPerson: {
            identifier: undefined,
            charname: '',
            dateofbirth: '',
            sex: '',
            phone_number: '',
            height: '',
            note: '',
            image: '',
            wanted: '',
        },
        searchCharges: '',
        newCharge: {
            identifier: undefined,
            title: '',
            incident: '',
            victim: '',
            author: '',
            charges: {},
            fine: 0,
            jailTime: 0,
            date: undefined,
            sentenced: '',
        },
        showCurrentCharge: {
            id: undefined,
            identifier: undefined,
            title: '',
            incident: '',
            victim: '',
            author: '',
            charges: {},
            fine: 0,
            jailTime: 0,
            date: undefined,
            sentenced: '',
        },
        selectedCharge: {},
        // Search Vehicles
        searchVehicle: '',
        VehicleResults: {},
        selectedVehicle: {
            owner: undefined,
            charname: '',
            model: '',
            type: '',
            plate: '',
            color: null,
            stolen: '',
            image: null,
        },

        // Warrants
        drxWarrants: [],
        searchVehicleWarrants: '',
        searchPersonsWarrants: '',
        searchWarrants: '',
        // warrants: [],
        vehicleWarrant: false,
        zvehicleWarrant: 0,
        vehicleWarrantSelected: {
            identifier: undefined,
            title: '',
            incident: '',
            victim: '',
            author: '',
            model: '',
            plate: '',
            warrants: {},
            date: undefined,
        },
        personWarrant: false,
        zpersonWarrant: 0,
        personWarrantSelected: {
            identifier: undefined,
            title: '',
            incident: '',
            victim: '',
            author: '',
            warrants: {},
            date: undefined,
        },
        showWarrants: false,
        zshowWarrants: 0,
        selectedWarrant: {
            id: undefined,
            identifier: undefined,
            title: '',
            incident: '',
            victim: '',
            author: '',
            model: '',
            plate: '',
            warrants: {},
            date: undefined,
        },

        // Dispatch
        drxDispatches: {},
        dispatch: false,
        zdispatch: 0,
        dispatchCall: {
            id: null,
            identifier: null,
            caller: '',
            details: '',
            date: '',
            location: '',
            respond: '',
        },
    }),

    methods: {
        // Basic
        openMenu(drxProfiles, drxDispatches, drxWarrants, identifier, vrpcharname, phone_number, dateofbirth, rank, charname, policegroup, badgenumber, duty, image) {
            this.isOpen = true;
            this.currentPage = 'HOME';

            // drx_mdt_profiles
            this.drxProfiles = drxProfiles;
            this.rank = rank;
            this.charname = charname;
            this.policegroup = policegroup;
            this.badgenumber = badgenumber;
            this.duty = duty;
            this.image = image;
            // vrp_user_identities
            this.identifier = identifier;
            this.vrpcharname = vrpcharname;
            this.phone_number = phone_number;
            this.dateofbirth = dateofbirth;
            // drx_mdt_dispatch
            this.drxDispatches = drxDispatches;
            // drx_mdt_warrants
            this.drxWarrants = drxWarrants;
        },
        closeMenu() {
            this.isOpen = false;
            this.managementChange = false;
            this.newCharges = false;
            this.changeCharges = false;
            this.showCharges = false;
            this.dispatch = false;
            this.vehicleWarrant = false;
            this.showWarrants = false;
            this.changeNote = false;
            this.searchVehicleWarrants = '';
            this.searchPersonsWarrants = '';
            this.searchInput = '';
            this.searchCharges = '';
            this.searchWarrants = '';
            $.post('https://drx_mdt/close');
        },
        changePage(MainPages) {
            this.currentPage = MainPages;
            this.managementChange = false;
            this.newCharges = false;
            this.changeCharges = false;
            this.showCharges = false;
            this.dispatch = false;
            this.vehicleWarrant = false;
            this.showWarrants = false;
            this.searchVehicleWarrants = '';
            this.searchPersonsWarrants = '';
            this.searchInput = '';
            this.searchCharges = '';
            this.searchWarrants = '';
        },



        // Criminal Records
        searchPerson(searchInput) {
            $.post('https://drx_mdt/searchPerson', JSON.stringify({
                searchInput
            }))
        },
        searchPersonClear() {
            this.searchInput = '';
            this.searchResults = {};
            this.selectedPerson.identifier = undefined;
            this.selectedPerson.charname = '';
            this.selectedPerson.dateofbirth = '';
            this.selectedPerson.sex = '';
            this.selectedPerson.phone_number = '';
            this.selectedPerson.height = '';
            this.selectedPerson.note = '';
            this.selectedPerson.image = '';
            this.selectedPerson.wanted = '';
        },
        selectPerson(identifier) {
            $.post('https://drx_mdt/fetchSelectPerson', JSON.stringify({
                identifier,
            }))
            this.selectedPerson.identifier = identifier;
        },
        changePersonImage() {
            $.post('https://drx_mdt/uploadPersonImage', JSON.stringify({
                identifier: this.selectedPerson.identifier,
                image: this.selectedPerson.image
            }))
        },
        saveNote(identifier, note) {
            identifier = this.selectedPerson.identifier;
            note = this.selectedPerson.note;
            if (this.selectedPerson.note.length == '') {
                $.post('https://drx_mdt/messageClient', JSON.stringify({
                    typeMessage: 'error',
                    message: 'Notes has been cleared',
                }))
                $.post('https://drx_mdt/saveNotes', JSON.stringify({
                    identifier,
                    note
                }))
            } else {
                $.post('https://drx_mdt/messageClient', JSON.stringify({
                    typeMessage: 'inform',
                    message: 'Notes has been saved',
                }))
                $.post('https://drx_mdt/saveNotes', JSON.stringify({
                    identifier,
                    note
                }))
            }
        },
        markPersonWanted() {
            if (this.selectedPerson.identifier) {
                $.post('https://drx_mdt/markPersonWanted', JSON.stringify({
                    identifier: this.selectedPerson.identifier,
                    wanted: this.selectedPerson.wanted,
                }))
            }
        },
        newChargeOverlay() {
            this.newCharges = true;
            this.newCharge.identifier = this.selectedPerson.identifier;
            this.newCharge.victim = this.selectedPerson.charname;
            this.newCharge.author = this.charname;

            this.newCharge.title = '';
            this.newCharge.incident = '';
            this.newCharge.charges = {};
            this.newCharge.fine = 0;
            this.newCharge.jailTime = 0;
            this.newCharge.date = undefined;
        },
        createNewCharge() {
            if (this.newCharge.title || this.newCharge.incident) {
                this.newCharges = false;
                this.changeCharges = false;
                $.post('https://drx_mdt/newCharge', JSON.stringify({
                    identifier: this.newCharge.identifier,
                    title: this.newCharge.title,
                    incident: this.newCharge.incident,
                    victim: this.newCharge.victim,
                    author: this.newCharge.author,
                    charges: this.newCharge.charges,
                    fine: this.newCharge.fine,
                    jailTime: this.newCharge.jailTime,
                    date: this.newCharge.date,
                    sentenced: this.newCharge.sentenced
                }))
            }
            this.newCharge.identifier = undefined;
            this.newCharge.title = '';
            this.newCharge.incident = '';
            this.newCharge.victim = '';
            this.newCharge.author = '';
            this.newCharge.charges = {};
            this.newCharge.fine = undefined;
            this.newCharge.jailTime = undefined;
            this.newCharge.date = undefined;
            this.newCharge.sentenced = '';
        },
        fetchLicenses() {
            this.showLicenses = true;
            $.post('https://drx_mdt/fetchLicenses', JSON.stringify({
                identifier: this.selectedPerson.identifier
            }))
        },
        returnLicenses(UserLicenses) {
            this.UserLicenses = UserLicenses;
        },
        removeLicense(data) {
            $.post('https://drx_mdt/removeLicenses', JSON.stringify({
                identifier: this.selectedPerson.identifier,
                licenseType: data
            }))
            this.showLicenses = false;
        },
        fetchPersonCharges() {
            this.changeCharges = true;
            $.post('https://drx_mdt/fetchCharges', JSON.stringify({
                identifier: this.selectedPerson.identifier
            }))
        },
        fetchCharges(selectedCharge) {
            this.selectedCharge = selectedCharge;
        },
        addFine(id) {
            for (var key in this.Fines) {
                if (id == this.Fines[key].id) {
                    var charge_name = this.Fines[key].label
                    if (this.newCharge.charges[charge_name]) {
                        Vue.set(this.newCharge.charges, charge_name, this.newCharge.charges[charge_name] + 1);
                    } else {
                        Vue.set(this.newCharge.charges, charge_name, 1);
                    }
                    this.newCharge.fine = this.newCharge.fine + this.Fines[key].amount
                    this.newCharge.jailTime = this.newCharge.jailTime + this.Fines[key].time
                    return;
                }
            }
        },
        removeFine(label) {
            for (var key in this.newCharge.charges) {
                if (label == key) {
                    if ((this.newCharge.charges[label] - 1) > 0) {
                        Vue.set(this.newCharge.charges, label, this.newCharge.charges[label] - 1)
                    } else {
                        Vue.delete(this.newCharge.charges, label)
                    }
                    for (var key in this.Fines) {
                        if (label == this.Fines[key].label) {
                            this.newCharge.fine = this.newCharge.fine - this.Fines[key].amount
                            this.newCharge.jailTime = this.newCharge.jailTime - this.Fines[key].time
                        }
                    }
                    return;
                }
            }
        },
        showCharge(id, identifier, title, incident, victim, author, charges, fine, jailTime, date, sentenced) {
            this.showCharges = true;
            this.showCurrentCharge.id = id;
            this.showCurrentCharge.identifier = identifier;
            this.showCurrentCharge.title = title;
            this.showCurrentCharge.incident = incident;
            this.showCurrentCharge.victim = victim;
            this.showCurrentCharge.author = author;
            this.showCurrentCharge.charges = charges;
            this.showCurrentCharge.fine = fine;
            this.showCurrentCharge.jailTime = jailTime;
            this.showCurrentCharge.date = date;
            this.showCurrentCharge.sentenced = sentenced;
        },
        sentenceTarget() {
            if (this.showCurrentCharge.sentenced === "Yes" || this.showCurrentCharge.title || this.showCurrentCharge.incident || this.showCurrentCharge.fine || this.showCurrentCharge.jailTime) {
                this.showCharges = false;
                this.changeCharges = false;
                $.post('https://drx_mdt/sentenceTarget', JSON.stringify({
                    id: this.showCurrentCharge.id,
                    identifier: this.showCurrentCharge.identifier,
                    title: this.showCurrentCharge.title,
                    incident: this.showCurrentCharge.incident,
                    victim: this.showCurrentCharge.victim,
                    author: this.showCurrentCharge.author,
                    charges: this.showCurrentCharge.charges,
                    fine: this.showCurrentCharge.fine,
                    jailTime: this.showCurrentCharge.jailTime,
                    date: this.showCurrentCharge.date,
                    sentenced: this.showCurrentCharge.sentenced
                }))
            }
        },
        deleteCharge() {
            if (this.rank === "admin") {
                this.showCharges = false;
                this.changeCharges = false;
                $.post('https://drx_mdt/deleteCharge', JSON.stringify({
                    id: this.showCurrentCharge.id
                }))
            }
        },
        editCharge() {
            if (this.showCurrentCharge.title.length >= 1 && this.showCurrentCharge.incident.length >= 1) {
                $.post('https://drx_mdt/editCharge', JSON.stringify({
                    id: this.showCurrentCharge.id,
                    title: this.showCurrentCharge.title,
                    details: this.showCurrentCharge.incident,
                    fine: this.showCurrentCharge.fine,
                    jailTime: this.showCurrentCharge.jailTime
                }))
                $.post('https://drx_mdt/messageClient', JSON.stringify({
                    typeMessage: 'inform',
                    message: 'Changes have been saved',
                }))
            } else {
                $.post('https://drx_mdt/messageClient', JSON.stringify({
                    typeMessage: 'error',
                    message: 'Title and details can not be empty'
                }))
            }
        },
        personWarrantOverlay() {
            if (this.selectedPerson.identifier) {
                this.personWarrant = true;

                this.personWarrantSelected.identifier = this.selectedPerson.identifier;
                this.personWarrantSelected.victim = this.selectedPerson.charname;
                this.personWarrantSelected.author = this.charname;
            }
        },





        // Search Vehicle
        searchVehicleInput(searchVehicle) {
            $.post('https://drx_mdt/searchVehicle', JSON.stringify({
                searchVehicle
            }))
        },
        searchVehicleClear() {
            this.searchVehicle = '';
            this.VehicleResults = {};
            this.selectedVehicle.owner = undefined;
            this.selectedVehicle.charname = '';
            this.selectedVehicle.model = '';
            this.selectedVehicle.type = '';
            this.selectedVehicle.plate = '';
            this.selectedVehicle.color = null;
            this.selectedVehicle.stolen = '';
            this.selectedVehicle.image = null;
        },
        selectVehicle(owner, plate) {
            $.post('https://drx_mdt/fetchSelectVehicle', JSON.stringify({
                owner,
                plate
            }))
            this.selectedVehicle.owner = owner;
        },
        changeVehicleImage() {
            $.post('https://drx_mdt/changeVehicleImage', JSON.stringify({
                owner: this.selectedVehicle.owner,
                plate: this.selectedVehicle.plate,
                image: this.selectedVehicle.image
            }))
        },
        markVehicleStolen() {
            if (this.selectedVehicle.owner || this.selectedVehicle.model || this.selectedVehicle.plate) {
                $.post('https://drx_mdt/markVehicleStolen', JSON.stringify({
                    owner: this.selectedVehicle.owner,
                    plate: this.selectedVehicle.plate,
                    stolen: this.selectedVehicle.stolen,
                    type: 'veh'
                }))
            }
        },
        vehicleWarrantOverlay() {
            if (this.selectedVehicle.owner || this.selectedVehicle.model || this.selectedVehicle.plate) {
                this.vehicleWarrant = true;

                this.vehicleWarrantSelected.identifier = this.selectedVehicle.owner;
                this.vehicleWarrantSelected.model = this.selectedVehicle.model;
                this.vehicleWarrantSelected.plate = this.selectedVehicle.plate;
                this.vehicleWarrantSelected.victim = this.selectedVehicle.charname;
                this.vehicleWarrantSelected.author = this.charname;
            }
        },






        // Dispatch
        locationDispatch(coords) {
            $.post('https://drx_mdt/locationDispatch', JSON.stringify({
                coords
            }))
        },
        respondDispatch(id, identifier, caller, details, date, location, respond) {
            this.dispatchCall.id = id;
            this.dispatchCall.identifier = identifier;
            this.dispatchCall.caller = caller;
            this.dispatchCall.details = details;
            this.dispatchCall.date = date;
            this.dispatchCall.location = location;
            this.dispatchCall.respond = respond;

            this.dispatch = true;
        },
        deleteDispatch(id) {
            $.post('https://drx_mdt/deleteDispatch', JSON.stringify({
                id
            }))
        },
        respondDispatchCall() {
            if (this.dispatchCall.id) {
                $.post('https://drx_mdt/respondDispatch', JSON.stringify({
                    id: this.dispatchCall.id,
                    identifier: this.dispatchCall.identifier,
                    respond: this.dispatchCall.respond
                }))
            }
        },







        // Warrants
        addWarrant(id) {
            if (this.currentPage == "SEARCH VEHICLES") {
                for (var key in this.WarrantsVehicle) {
                    if (id == this.WarrantsVehicle[key].id) {
                        var charge_name = this.WarrantsVehicle[key].label
                        if (this.vehicleWarrantSelected.warrants[charge_name]) {
                            Vue.set(this.vehicleWarrantSelected.warrants, charge_name, this.vehicleWarrantSelected.warrants[charge_name] + 1);
                        } else {
                            Vue.set(this.vehicleWarrantSelected.warrants, charge_name, 1);
                        }
                    }
                }
            } else {
                for (var key in this.WarrantsPerson) {
                    if (id == this.WarrantsPerson[key].id) {
                        var charge_name = this.WarrantsPerson[key].label
                        if (this.personWarrantSelected.warrants[charge_name]) {
                            Vue.set(this.personWarrantSelected.warrants, charge_name, this.personWarrantSelected.warrants[charge_name] + 1);
                        } else {
                            Vue.set(this.personWarrantSelected.warrants, charge_name, 1);
                        }
                    }
                }
            }
        },
        removeWarrant(label) {
            if (this.currentPage == "SEARCH VEHICLES") {
                for (var key in this.vehicleWarrantSelected.warrants) {
                    if (label == key) {
                        if ((this.vehicleWarrantSelected.warrants[label] - 1) > 0) {
                            Vue.set(this.vehicleWarrantSelected.warrants, label, this.vehicleWarrantSelected.warrants[label] - 1)
                        } else {
                            Vue.delete(this.vehicleWarrantSelected.warrants, label)
                        }
                    }
                }
            } else {
                for (var key in this.personWarrantSelected.warrants) {
                    if (label == key) {
                        if ((this.personWarrantSelected.warrants[label] - 1) > 0) {
                            Vue.set(this.personWarrantSelected.warrants, label, this.personWarrantSelected.warrants[label] - 1)
                        } else {
                            Vue.delete(this.personWarrantSelected.warrants, label)
                        }
                    }
                }
            }
        },
        createNewWarrant() {
            if (this.currentPage == "SEARCH VEHICLES") {
                if (this.vehicleWarrantSelected.title || this.vehicleWarrantSelected.incident) {
                    this.vehicleWarrant = false;
                    $.post('https://drx_mdt/newWarrant', JSON.stringify({
                        identifier: this.vehicleWarrantSelected.identifier,
                        title: this.vehicleWarrantSelected.title,
                        incident: this.vehicleWarrantSelected.incident,
                        victim: this.vehicleWarrantSelected.victim,
                        author: this.vehicleWarrantSelected.author,
                        model: this.vehicleWarrantSelected.model,
                        plate: this.vehicleWarrantSelected.plate,
                        warrants: this.vehicleWarrantSelected.warrants,
                        type: 'veh'
                    }))
                }
                this.vehicleWarrantSelected.identifier = undefined;
                this.vehicleWarrantSelected.title = '';
                this.vehicleWarrantSelected.incident = '';
                this.vehicleWarrantSelected.victim = '';
                this.vehicleWarrantSelected.author = '';
                this.vehicleWarrantSelected.model = '';
                this.vehicleWarrantSelected.plate = '';
                this.vehicleWarrantSelected.warrants = {};
                this.vehicleWarrantSelected.date = undefined;
            } else {
                if (this.personWarrantSelected.title || this.personWarrantSelected.incident) {
                    this.personWarrant = false;
                    $.post('https://drx_mdt/newWarrant', JSON.stringify({
                        identifier: this.personWarrantSelected.identifier,
                        title: this.personWarrantSelected.title,
                        incident: this.personWarrantSelected.incident,
                        victim: this.personWarrantSelected.victim,
                        author: this.personWarrantSelected.author,
                        warrants: this.personWarrantSelected.warrants,
                        type: 'person'
                    }))
                }
                this.personWarrantSelected.identifier = undefined;
                this.personWarrantSelected.title = '';
                this.personWarrantSelected.incident = '';
                this.personWarrantSelected.victim = '';
                this.personWarrantSelected.author = '';
                this.personWarrantSelected.warrants = {};
                this.personWarrantSelected.date = undefined;
            }
        },
        viewVehicleWarrant(id, identifier, title, incident, victim, author, model, plate, date, warrants) {
            this.showWarrants = true;
            this.selectedWarrant.id = id;
            this.selectedWarrant.identifier = identifier;
            this.selectedWarrant.title = title;
            this.selectedWarrant.incident = incident;
            this.selectedWarrant.victim = victim;
            this.selectedWarrant.author = author;
            this.selectedWarrant.model = model;
            this.selectedWarrant.plate = plate;
            this.selectedWarrant.date = date;
            this.selectedWarrant.warrants = warrants;
        },
        viewPersonWarrant(id, identifier, title, incident, victim, author, date, warrants) {
            this.showWarrants = true;
            this.selectedWarrant.id = id;
            this.selectedWarrant.identifier = identifier;
            this.selectedWarrant.title = title;
            this.selectedWarrant.incident = incident;
            this.selectedWarrant.victim = victim;
            this.selectedWarrant.author = author;
            this.selectedWarrant.date = date;
            this.selectedWarrant.warrants = warrants;
        },
        deleteWarrant(id) {
            if (id) {
                $.post('https://drx_mdt/deleteWarrant', JSON.stringify({
                    id
                }))
            }
        },



        // Profile
        dutyStatus(duty) {
            $.post('https://drx_mdt/dutyStatus', JSON.stringify({
                duty,
            }))
        },
        changeImage(image) {
            this.imageChange = false;
            $.post('https://drx_mdt/changeImage', JSON.stringify({
                image
            }))
        },
        changeEmployeeData(identifier, rank, charname, policegroup, badgenumber, duty, image) {
            this.managementChange = true;
            this.identifierData = identifier;
            this.rankData = rank;
            this.charnameData = charname;
            this.policegroupData = policegroup;
            this.badgenumberData = badgenumber;
            this.dutyData = duty;
            this.imageData = image;
        },
        changeComitData(identifierData, rankData, policegroupData, badgenumberData, imageData) {
            if (this.identifier === this.identifierData) {
                this.policegroup = policegroupData;
                this.badgenumber = badgenumberData;
                this.image = imageData;
                $.post('https://drx_mdt/changeComitData', JSON.stringify({
                    identifierData,
                    rankData,
                    policegroupData,
                    badgenumberData,
                    imageData
                }))
            } else {
                $.post('https://drx_mdt/changeComitData', JSON.stringify({
                    identifierData,
                    rankData,
                    policegroupData,
                    badgenumberData,
                    imageData
                }))
            }
        },
        DeleteData(identifierData) {
            if (this.identifier === this.identifierData) {
                $.post('https://drx_mdt/messageClient', JSON.stringify({
                    typeMessage: 'inform',
                    message: 'You are admin, you cannot delete yourself',
                }))
            } else {
                this.managementChange = false;
                $.post('https://drx_mdt/deleteData', JSON.stringify({
                    identifierData
                }))
            }
        },



        // Updates
        returnSelectPerson(charname, dateofbirth, phone_number, sex, height, note, image, wanted) {
            this.selectedPerson.charname = charname;
            this.selectedPerson.dateofbirth = dateofbirth;
            this.selectedPerson.phone_number = phone_number;
            this.selectedPerson.sex = sex;
            this.selectedPerson.height = height;
            this.selectedPerson.note = note;
            this.selectedPerson.image = image;
            this.selectedPerson.wanted = wanted;
        },
        returnWantedStatus(wanted) {
            this.selectedPerson.wanted = wanted;
        },
        updateDuty(duty) {
            this.duty = duty;
        },
        updateDutyAll(drxProfiles) {
            this.drxProfiles = drxProfiles;
        },
        // returnWarrants(warrants) {
        //     this.warrants = warrants;
        // },
        searchPersonResults(searchResults) {
            this.searchResults = searchResults;
        },
        returnVehicleResults(VehicleResults) {
            this.VehicleResults = VehicleResults;
        },
        returnSelectVehicle(charname, model, plate, type, color, stolen, image) {
            this.selectedVehicle.charname = charname;
            this.selectedVehicle.model = model;
            this.selectedVehicle.plate = plate;
            this.selectedVehicle.type = type;
            this.selectedVehicle.color = color;
            this.selectedVehicle.stolen = stolen;
            this.selectedVehicle.image = image;
        },
        returnStatusStolen(stolen) {
            this.selectedVehicle.stolen = stolen;
        },
        updateDispatches(drxDispatches) {
            this.drxDispatches = drxDispatches;
        },
        updateAllWarrants(drxWarrants) {
            this.drxWarrants = drxWarrants;
        },
    },

    computed: {
        FilterCharges() {
            return this.Fines.filter((charges) => {
                return this.searchCharges.toLowerCase().split(' ').every(v => charges.label.toLowerCase().includes(v))
            })
        },
        FilterWarrants() {
            return this.WarrantsPerson.filter((warrants) => {
                return this.searchWarrants.toLowerCase().split(' ').every(v => warrants.label.toLowerCase().includes(v))
            })
        },
        FilterVehWarrants() {
            return this.WarrantsVehicle.filter((warrants) => {
                return this.searchWarrants.toLowerCase().split(' ').every(v => warrants.label.toLowerCase().includes(v))
            })
        },
        FilterVehiclesWarrantsPage() {
            return this.drxWarrants.filter((warrants) => {
                return this.searchVehicleWarrants.toLowerCase().split(' ').every(v => warrants.victim.toLowerCase().includes(v))
            })
        },
        FilterPersonsWarrantsPage() {
            return this.drxWarrants.filter((warrants) => {
                return this.searchPersonsWarrants.toLowerCase().split(' ').every(v => warrants.victim.toLowerCase().includes(v))
            })
        },
    },
})

document.onreadystatechange = () => {
    if (document.readyState == 'complete') {
        window.addEventListener('message', (event) => {
            var drx = event.data;

            if (drx.open) {
                drx_mdt.openMenu(drx.drxProfiles, drx.drxDispatches, drx.drxWarrants, drx.identifier, drx.vrpcharname, drx.phone_number, drx.dateofbirth, drx.rank, drx.charname, drx.policegroup, drx.badgenumber, drx.duty, drx.image, drx.warrants)
            }

            if (drx.close) {
                drx_mdt.closeMenu()
            }

            if (drx.type == 'returnSearchPerson') {
                drx_mdt.searchPersonResults(drx.searchResults)
            }

            if (drx.type == 'returnSelectPerson') {
                drx_mdt.returnSelectPerson(drx.charname, drx.dateofbirth, drx.phone_number, drx.sex, drx.note, drx.image, drx.wanted)
            }

            if (drx.type == 'returnWantedStatus') {
                drx_mdt.returnWantedStatus(drx.wanted)
            }

            if (drx.type == 'updateDuty') {
                drx_mdt.updateDuty(drx.duty)
            }

            if (drx.type == 'updateDutyAll') {
                drx_mdt.updateDutyAll(drx.drxProfiles)
            }

            if (drx.type == 'returnLicenses') {
                drx_mdt.returnLicenses(drx.UserLicenses)
            }

            if (drx.type == 'returnCharges') {
                drx_mdt.fetchCharges(drx.selectedCharge)
            }

            if (drx.type == 'returnWarrants') {
                drx_mdt.returnWarrants(drx.warrants)
            }

            if (drx.type == 'returnSearchVehicle') {
                drx_mdt.returnVehicleResults(drx.VehicleResults)
            }

            if (drx.update == 'returnSelectVehicle') {
                drx_mdt.returnSelectVehicle(drx.charname, drx.model, drx.plate, drx.type, drx.color, drx.stolen, drx.image)
            }

            if (drx.type == 'returnStolenStatus') {
                drx_mdt.returnStatusStolen(drx.stolen)
            }

            if (drx.type == 'updateDispatches') {
                drx_mdt.updateDispatches(drx.drxDispatches)
            }

            if (drx.type == 'updateAllWarrants') {
                drx_mdt.updateAllWarrants(drx.drxWarrants)
            }

            if (drx.type == 'updateWarrants') {
                drx_mdt.changePage('WARRANTS')
            }

            document.onkeyup = function(data) {
                if (data.which == 27) {
                    drx_mdt.closeMenu();
                }
            };
        });
    };
};