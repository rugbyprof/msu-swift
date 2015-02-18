<?php
namespace PhalconRest\Controllers;
use \PhalconRest\Exceptions\HTTPException,
    PhalconRest\Models\Users as Users,
	PhalconRest\Models\Messages as Messages,
	PhalconRest\Models\Facilities as Facilities,
	PhalconRest\Models\UserInvites as UserInvites,
	PhalconRest\Controllers\Emailer as Emailer,
	PhalconRest\Controllers\TokenConverter as TokenConverter;

use Swagger\Annotations as SWG;

/**
 * @package
 * @category
 * @subpackage
 *
 * @SWG\Resource(
 *   apiVersion="1.0.0",
 *   swaggerVersion="1.2",
 *   basePath="http://killzombieswith.us/aii-api/v1",
 *   resourcePath="/users",
 *   description="Requests about Users Information",
 *   produces="['application/json','application/xml','text/plain']"
 * )
 */



class UsersController extends RESTController{

    /**
     * Sets which fields may be searched against, and which fields are allowed to be returned in
     * partial responses.
     * @var array
     */
    protected $allowedFields = array(
        'search' => array('UserID','FacilityID','UserLevelID','ip_address','username','password','salt',
                          'email','activation_code','forgotten_password_code','forgotten_password_time',
						  'remember_code','created_on','last_login','active','first_name','last_name',
						  'phone','TitleID'),
        'partials' => array('UserID','FacilityID','UserLevelID','ip_address','username','password','salt',
                          'email','activation_code','forgotten_password_code','forgotten_password_time',
						  'remember_code','created_on','last_login','active','first_name','last_name',
						  'phone','TitleID')
    );

    /**
     * @SWG\Api(
     *   path="/users/",
     *   @SWG\Operation(
     *     method="GET",
     *     summary="Retrieve users set",
     *     notes="Returns all users",
     *     type="User",
     *     nickname="user",
     *     @SWG\ResponseMessage(code=404, message="Questions not found")
     *   )
     * )
     */
    public function get($token){
        
        //Currently can only get all users if there is an active session in sessions log table
        $isActive = TokenConverter::isTokenActive($token);
		if(is_array($isActive) && isset($isActive['error'])){
            return $isActive;
        }
        
        //if active, can do search, sort, or get on all records
        if($this->isSearch){
            $results = $this->search();
        } else if ($this->isSorted) {
			$result = Users::query()
				->order($this->sortFields)
				->execute();
			$results = $result->toArray();
		} else {
            $result = Users::find();
			$results = $result->toArray();
			
        }

        return $this->respond($results);
    }

    /**
     * @SWG\Api(
     *   path="/users/{id}",
     *   @SWG\Operation(
     *     method="GET",
     *     summary="Find user by ID",
     *     notes="Returns a user based on ID",
     *     type="User",
     *     nickname="getUser",
     *     @SWG\Parameter(
     *       name="userID",
     *       description="ID of user that needs to be fetched",
     *       required=true,
     *       type="integer",
     *       format="int64",
     *       paramType="path",
     *       minimum="1.0",
     *       maximum="100000.0"
     *     ),
     *     @SWG\ResponseMessage(code=400, message="Invalid ID supplied"),
     *     @SWG\ResponseMessage(code=404, message="Question not found")
     *   )
     * )
     */
    public function getOne($token){
	
		//Get UserID from the token
		$id = TokenConverter::get($token, "UserID");
		
		//If the token is invalid, return a record of false
		if(is_array($id) && isset($id['error'])){
			return $id;
		}
		
		//Grab the user by their UserID
        $result = Users::findFirst("UserID='{$id}'");
		$user = $result->toArray();
		
		//Find the user's title by their TitleID
		$user['Title'] = $result->getUserTitle()->Abbreviation;
		//Return the user's full name
		$user['Name'] = $user['first_name'] . " " . $user['last_name'];
		
        return $user;
    }
	
	//Populates the 'Inbox' with user-received messages
	public function getUserReceivedMessages($token){
	
		// Convert the token into user information
		$userID = TokenConverter::get($token, "UserID");
<<<<<<< HEAD
        
		//If the token is invalid, return the error
		if(is_array($userID) && isset($userID['error'])){
=======
		
		//Check if the token was valid before grabbing more information
		if(!isset($userID['error'])){
			$messages=array();
			$user = Users::find("UserID='{$userID}'");
			$inboxMessages = $user[0]->getReceivedMessages(array("conditions" =>"Sent='1' AND ReceiverDeleted='0'"));
			
			foreach($inboxMessages as $inboxMessage){
				$inboxMessage = $inboxMessage->toArray();
				
                $SID = $inboxMessage['SenderID'];
                $RID = $inboxMessage['ReceiverID'];

//				$sender = Users::find("UserID='{$SID}'")[0];
//				$receiver = Users::find("UserID='{$RID}'")[0];
				$sender = Users::findFirst("UserID='{$SID}'");
				$receiver = Users::findFirst("UserID='{$RID}'");
				
				$inboxMessage['Sender_First'] = $sender->first_name;
				$inboxMessage['Sender_Last'] = $sender->last_name;
				
				$inboxMessage['SenderUsername'] = $sender->username;
				$inboxMessage['ReceiverUsername'] = $receiver->username;
				$messages[]=$inboxMessage;
			}
			
			return $this->respond($messages);
		}
		//If the token was invalid, return false
		else{
>>>>>>> d04b231582d7cde7941dc56319fb58f9c41a0d0b
			return $userID;
		}

        $messages=array();
        $user = Users::find("UserID='{$userID}'");
        $inboxMessages = $user[0]->getReceivedMessages(array("conditions" =>"Sent='1' AND ReceiverDeleted='0'"));

        foreach($inboxMessages as $inboxMessage){
            $inboxMessage = $inboxMessage->toArray();

            $SID = $inboxMessage['SenderID'];
            $RID = $inboxMessage['ReceiverID'];

//				$sender = Users::find("UserID='{$SID}'")[0];
//				$receiver = Users::find("UserID='{$RID}'")[0];
            $sender = Users::findFirst("UserID='{$SID}'");
            $receiver = Users::findFirst("UserID='{$RID}'");

            $inboxMessage['Sender_First'] = $sender->first_name;
            $inboxMessage['Sender_Last'] = $sender->last_name;

            $inboxMessage['SenderUsername'] = $sender->username;
            $inboxMessage['ReceiverUsername'] = $receiver->username;
            $messages[]=$inboxMessage;
        }

        return $this->respond($messages);
		
	}
	
	//Populates the 'Sent' with user-sent messages
	public function getUserSentMessages($token){
		$userID = TokenConverter::get($token, 'UserID');
		
<<<<<<< HEAD
        //If the token is invalid, return the error
		if(is_array($userID) && isset($userID['error'])){
=======
		if(!isset($userID['error'])){
			$messages = array();	
			$user = Users::find("UserID='{$userID}'");
			//Grab all of the user's sent (and not deleted) messages 
			$sentMessages = $user[0]->getSentMessages(array("conditions" =>"Sent='1' AND SenderDeleted='0'"));
			
			foreach($sentMessages as $sentMessage){
				$sentMessage = $sentMessage->toArray();

                $SID = $sentMessage['SenderID'];
                $RID = $sentMessage['ReceiverID'];


				$sender = Users::findFirst("UserID='{$SID}'");
				$receiver = Users::findFirst("UserID='{$RID}'");
				
				$sentMessage['Receiver_First'] = $receiver->first_name;
				$sentMessage['Receiver_Last'] = $receiver->last_name;
				
				$sentMessage['SenderUsername'] = $sender->username;
				$sentMessage['ReceiverUsername'] = $receiver->username;
				
				$messages[]=$sentMessage;
			}
		
			return $this->respond($messages);
		}
		else {
>>>>>>> d04b231582d7cde7941dc56319fb58f9c41a0d0b
			return $userID;
		}
		
        $messages = array();	
        $user = Users::find("UserID='{$userID}'");
        //Grab all of the user's sent (and not deleted) messages 
        $sentMessages = $user[0]->getSentMessages(array("conditions" =>"Sent='1' AND SenderDeleted='0'"));

        foreach($sentMessages as $sentMessage){
            $sentMessage = $sentMessage->toArray();

            $SID = $sentMessage['SenderID'];
            $RID = $sentMessage['ReceiverID'];


            $sender = Users::findFirst("UserID='{$SID}'");
            $receiver = Users::findFirst("UserID='{$RID}'");

            $sentMessage['Receiver_First'] = $receiver->first_name;
            $sentMessage['Receiver_Last'] = $receiver->last_name;

            $sentMessage['SenderUsername'] = $sender->username;
            $sentMessage['ReceiverUsername'] = $receiver->username;

            $messages[]=$sentMessage;
        }

        return $this->respond($messages);
		
	}
	
	//Populates the 'Drafts' with unsent messages
	public function getDrafts($token){
		$userID = TokenConverter::get($token, 'UserID');
<<<<<<< HEAD
        
        //If the token is invalid, return the error
		if(is_array($userID) && isset($userID['error'])){
=======
		
		if(!isset($userID['error'])){
			$messages = array();
			$user = Users::find("UserID='{$userID}'");
			//Grab all of the messages where the SenderID = UserID
			$sentMessages = $user[0]->getSentMessages(array("conditions" => "Sent='0' AND SenderDeleted='0'"));
			
			foreach($sentMessages as $sentMessage){
				$sentMessage = $sentMessage->toArray();
				
                $RID = $sentMessage['ReceiverID'];
                $SID = $sentMessage['SenderID'];

				if($sentMessage->ReceiverID != 0){
					$receiver = Users::findFirst("UserID='{$RID}'");
					$sentMessage['ReceiverUsername'] = $receiver->username;
				}
				
				$sender = Users::findFirst("UserID='{$SID}'");
				$sentMessage['SenderUsername'] = $sender->username;
				
				$messages[]=$sentMessage;
			}
			
			return $this->respond($messages);
		}
		else {
>>>>>>> d04b231582d7cde7941dc56319fb58f9c41a0d0b
			return $userID;
		}
		
		
        $messages = array();
        $user = Users::find("UserID='{$userID}'");
        //Grab all of the messages where the SenderID = UserID
        $sentMessages = $user[0]->getSentMessages(array("conditions" => "Sent='0' AND SenderDeleted='0'"));

        foreach($sentMessages as $sentMessage){
            $sentMessage = $sentMessage->toArray();

            $RID = $sentMessage['ReceiverID'];
            $SID = $sentMessage['SenderID'];

            if($sentMessage->ReceiverID != 0){
                $receiver = Users::findFirst("UserID='{$RID}'");
                $sentMessage['ReceiverUsername'] = $receiver->username;
            }

            $sender = Users::findFirst("UserID='{$SID}'");
            $sentMessage['SenderUsername'] = $sender->username;

            $messages[]=$sentMessage;
        }

        return $this->respond($messages);
		
	}
	
	//Populates the 'Trash' with messages the user has deleted
	public function getDeleted($token){
		$userID = TokenConverter::get($token, 'UserID');
		
<<<<<<< HEAD
        //If the token is invalid, return the error
		if(is_array($userID) && isset($userID['error'])){
=======
		if(!isset($userID['error'])){
			$messages = array();
			$user = Users::find("UserID='{$userID}'");
			$sentMessages = $user[0]->getSentMessages(array("conditions" => "Sent='1' AND SenderDeleted='1'"));
			foreach($sentMessages as $sentMessage){
				$sentMessage = $sentMessage->toArray();

                $RID = $sentMessage['ReceiverID'];
                $SID = $sentMessage['SenderID'];

				$sender = Users::findFirst("UserID='{$SID}'");
				$receiver = Users::findFirst("UserID='{$RID}'");
				
				$sentMessage['Receiver_First'] = $receiver->first_name;
				$sentMessage['Receiver_Last'] = $receiver->last_name;
				
				$sentMessage['SenderUsername'] = $sender->username;
				$sentMessage['ReceiverUsername'] = $receiver->username;
				
				$messages[]=$sentMessage;
			}
			
			$receivedMessages = $user[0]->getReceivedMessages(array("conditions" =>"Sent='1' AND ReceiverDeleted='1'"));
			foreach($receivedMessages as $receivedMessage){
				$receivedMessage = $receivedMessage->toArray();

                $RID = $receivedMessage['ReceiverID'];
                $SID = $receivedMessage['SenderID'];

				$sender = Users::findFirst("UserID='{$SID}'");
				$receiver = Users::findFirst("UserID='{$RID}'");

				$receivedMessage['Sender_First'] = $sender->first_name;
				$receivedMessage['Sender_Last'] = $sender->last_name;
				$receivedMessage['SenderUsername'] = $sender->username;
				$receivedMessage['ReceiverUsername'] = $receiver->username;
				$messages[]=$receivedMessage;
			}
			
			//var_dump($deletedMessages);
			return $this->respond($messages);
		}
		else {
>>>>>>> d04b231582d7cde7941dc56319fb58f9c41a0d0b
			return $userID;
		}
	
        $messages = array();
        $user = Users::find("UserID='{$userID}'");
        $sentMessages = $user[0]->getSentMessages(array("conditions" => "Sent='1' AND SenderDeleted='1'"));
        foreach($sentMessages as $sentMessage){
            $sentMessage = $sentMessage->toArray();

            $RID = $sentMessage['ReceiverID'];
            $SID = $sentMessage['SenderID'];

            $sender = Users::findFirst("UserID='{$SID}'");
            $receiver = Users::findFirst("UserID='{$RID}'");

            $sentMessage['Receiver_First'] = $receiver->first_name;
            $sentMessage['Receiver_Last'] = $receiver->last_name;

            $sentMessage['SenderUsername'] = $sender->username;
            $sentMessage['ReceiverUsername'] = $receiver->username;

            $messages[]=$sentMessage;
        }

        $receivedMessages = $user[0]->getReceivedMessages(array("conditions" =>"Sent='1' AND ReceiverDeleted='1'"));
        foreach($receivedMessages as $receivedMessage){
            $receivedMessage = $receivedMessage->toArray();

            $RID = $receivedMessage['ReceiverID'];
            $SID = $receivedMessage['SenderID'];

            $sender = Users::findFirst("UserID='{$SID}'");
            $receiver = Users::findFirst("UserID='{$RID}'");                

            $receivedMessage['Sender_First'] = $sender->first_name;
            $receivedMessage['Sender_Last'] = $sender->last_name;
            $receivedMessage['SenderUsername'] = $sender->username;
            $receivedMessage['ReceiverUsername'] = $receiver->username;
            $messages[]=$receivedMessage;
        }

        //var_dump($deletedMessages);
        return $this->respond($messages);
		
	}
	
    //get all unread counts...
	public function getUnreadCount($token){
	
        //Get FacilityID from the token
		$facid = TokenConverter::get($token, "FacilityID");

		// Convert the token into user information
		$userID = TokenConverter::get($token, "UserID");
		
        //If the token is invalid, return the error
		if(is_array($userID) && isset($userID['error'])){
			return $userID;
		}
		
        $user = Users::find("UserID='{$userID}'");
        $unreadMessages = $user[0]->getReceivedMessages(array("conditions" =>"Sent='1' AND ReceiverDeleted='0' AND IsRead='0'"));
        $facility = Facilities::findFirst("FacilityID='{$facid}'");
        $unreadAlerts = $facility->getReceivedAlerts(array("conditions" => "IsArchived='0' AND IsRead='0'"));
        $unreadNotifications = $facility->getReceivedNotifications(array("conditions" => "IsArchived='0' AND IsRead='0'"));
        $data = array();
        $data['notificationCount'] = count($unreadNotifications);
        $data['messageCount'] = count($unreadMessages);
        $data['alertCount'] = count($unreadAlerts);
        $data['totalUnreadCount']= $data['alertCount']+ $data['messageCount'] +$data['notificationCount'];
        return($data);
		
	}
	
	//Get user's unread inbox messages
	public function getUnreadMessages($token){
		// Convert the token into user information
		$userID = TokenConverter::get($token, "UserID");
		
        //If the token is invalid, return the error
		if(is_array($userID) && isset($userID['error'])){
			return $userID;
		}
        
        $messages=array();
        $user = Users::findFirst("UserID='{$userID}'");
        $inboxMessages = $user->getReceivedMessages(array("conditions" =>"Sent='1' AND ReceiverDeleted='0' AND IsRead='0'"));

        foreach($inboxMessages as $inboxMessage){
            $inboxMessage = $inboxMessage->toArray();

            //Messages to be returned. Only contains 3 fields.
            $shortMessage = array();

            $sender = Users::findFirst("UserID='{$inboxMessage['SenderID']}'");
            $receiver = Users::findFirst("UserID='{$inboxMessage['ReceiverID']}'");

            //Define the message fields
            $shortMessage['MessageID'] = $inboxMessage['MessageID'];
            $shortMessage['Sender'] = $sender->first_name . " " . $sender->last_name;
            $shortMessage['SenderUsername'] = $sender->username;
            $shortMessage['Subject'] = $inboxMessage['Subject'];
            $shortMessage['Timestamp'] = $inboxMessage['Timestamp'];
            $messages[]=$shortMessage;
        }

        return $this->respond($messages);
		
	}
	
	//Register a new user.
	//Post information should include:
	//  - Username : new user's username
	//  - Password : password must be sha1 encrypted by the front-end
	//  - First : recipient's first name
	//  - Last : recipient's last name
	//  - $token : One-time token in the query parameter of the registration URL
	public function post($token){
		//Initialize response message
		$responseMessage["response"] = "";
		
		//Grab POST info
		$userForm = $this->di->get('requestBody');
		
		//Grab the user information from the token
		$tokenInfo = UserInvites::findFirst("Token='{$token}'");
		
		//Check if token exists
		if(!$tokenInfo){
			$responseMessage["response"] = 1020;
			return $responseMessage;
		}
		
		//Check if username has already been used
		$userWithUsername = Users::findFirst("username='{$userForm->Username}'");
		if($userWithUsername){
			$responseMessage["response"] = 1010;
			return $responseMessage;
		}
		
		//Define the new user
		$user = new Users();
		$user->FacilityID  = $tokenInfo->FacilityID;
		
		$user->username    = $userForm->Username;
		$user->salt        = sha1(rand());
		$user->password    = hash('sha256', ($userForm->Password . $user->salt));
		$user->email	   = $tokenInfo->Email;
		$user->ip_address  = $_SERVER['REMOTE_ADDR'];
		$user->created_on  = time();
		$user->active      = 1;
		$user->first_name  = $userForm->First;
		$user->last_name   = $userForm->Last;
		$user->TitleID 	   = $tokenInfo->TitleID;
        //Doctors or audiologist's get higher levels of access
        if($user->TitleID == 1 || $user->TitleID == 3){
            $user->UserLevelID = 15;
        }else{
            $user->UserLevelID = 20;
        }
		$user->IsArchived  = 0;
		$user->CanEmail    = 1;
		
		//Save the new user
		if($user->save()){
            $responseMessage["response"] = "New user has been registered\n";
			
			//If the save was successful, remove the token from UserInvites
			$tokenInfo->delete();
			
			//Return a successful response
			$responseMessage["response"] = 1000;
	    }
		//If record could not save, return the error messages
        else{
            $messages = $user->getMessages();
			$responseMessage["response"] = 1030;
            $responseMessage["User Registration Response"] = "Sorry, the following problems were generated: \n";
            foreach ($messages as $message) {
                $responseMessage["User Registration Response"] = $responseMessage["User Registration Response"] . $message . ".\n";
            }
        }
		return $responseMessage;
	}

    public function delete($id){
        return array('Delete / stub');
    }

    /**
     * @SWG\Api(
     *   path="/users/{id}",
     *   @SWG\Operation(
     *     method="PUT",
     *     summary="Update a user record",
     *     notes="Edit a user into users table",
     *     type="Users",
     *     nickname="user",
     *     @SWG\ResponseMessage(code=???, message=" ")
     *   )
     * )
     */
    public function put($token){
        //$user set to the existing record in Users table where UserID= id in url 
        $id = TokenConverter::get($token, 'UserID');
        
        //If the token is invalid, return a record of false
		if(is_array($id) && isset($id['error'])){
			return $id;
		}
        
        $user = Users::findFirst("UserID='{$id}'");
        
        $userEdit = $this->di->get('requestBody');  //call requestBody in index to grab json object from front end
                                                //requestBody returns contents to $userEdit
    
        $user->username    = $userEdit->username;
		$user->email	   = $userEdit->email;
        
        $user->update();
        //if user wanted a new password, and current $user password is the same as what user entered as current..
        //change the user password to what was entered
        //hash the passwords
        $userEdit->currentPassword = hash('sha256', ($userEdit->currentPassword . $user->salt));
        //echo($userEdit->currentPassword) . '\n';
        //echo(hash('sha256', ('password'. $user->salt)));
        if($userEdit->newPassword && $userEdit->currentPassword == $user->password) { 
            $user->password = hash('sha256', ($userEdit->newPassword . $user->salt));

        }elseif($userEdit->newPassword) {
            $responseMessage["User Edit Response"] = "Current Password Incorrect. Try Again";
            return $responseMessage;
        }
        
        $user->update();

        if ($user->update() == true) {
            $responseMessage["User Edit Response"] = "Successfully saved your user settings";
        } else {
            echo "Sorry, the following problems were generated: ";
            foreach ($user->getMessages() as $message) {
                $responseMessage["User Edit Response"] = $responseMessage["User Edit Response"] . $message->getMessage();
            }
        }
            
        return $responseMessage;
        //return array('Put / stub');
    }

    public function patch($id){
        return array('Patch / stub');
    }

    public function search(){
        $records = Users::find();
        $records = $records->toArray();
        $results = array();
        foreach($records as $record){
            $match = true;
            foreach ($this->searchFields as $field => $value) {
                if(!(strpos(strtolower($record[$field]), strtolower($value)) !== FALSE)){
                    $match = false;
                }
            }
            if($match){
                $results[] = $record;
            }
        }

        return $results;
    }	
}
