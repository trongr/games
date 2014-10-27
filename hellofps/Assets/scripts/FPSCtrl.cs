using UnityEngine;
using System.Collections;

[RequireComponent (typeof(CharacterController))]
public class FPSCtrl : MonoBehaviour {

	public float MOVESPD = 10f;
	public float UPDOWN_MOUSE_SENSITIVITY = 200f;
	public float LEFTRIGHT_MOUSE_SENSITIVITY = 2f;
	public float UPDOWN_CAM_RANGE = 60f;
	public float JUMPSPD = 10f;
	public float TERMINAL_VELOCITY = -200f;

	public float verticalvelocity; // player vertical velocity. public so you can see its values for debugging
	
	CharacterController cc;
	Vector3 updownangles = Vector3.zero; // to cap up down camera angles

	// Use this for initialization
	void Start () {
		Camera.main.transform.localEulerAngles = updownangles;
		Screen.lockCursor = true; // hides mouse pointer
		cc = GetComponent<CharacterController> ();
	}
	
	// Update is called once per frame
	void Update () {
		// rotation
		float mouseleftright = Input.GetAxis ("Mouse X") * LEFTRIGHT_MOUSE_SENSITIVITY;
		transform.Rotate (0, mouseleftright, 0);

		updownangles.x -= Input.GetAxis ("Mouse Y") * UPDOWN_MOUSE_SENSITIVITY * Time.deltaTime;
		updownangles.x = Mathf.Clamp (updownangles.x, -UPDOWN_CAM_RANGE, UPDOWN_CAM_RANGE);
		Camera.main.transform.localEulerAngles = updownangles;

		// movement
		float forwardspd = Input.GetAxis ("Vertical") * MOVESPD;
		float sidespd = Input.GetAxis ("Horizontal") * MOVESPD;

		verticalvelocity += Physics.gravity.y * Time.deltaTime; // adding velocity to accelerate
		verticalvelocity = verticalvelocity > TERMINAL_VELOCITY ? verticalvelocity : TERMINAL_VELOCITY; // set terminal velocity so we don't get a huge number even though player's not falling
		if (Input.GetButtonDown ("Jump")){
			verticalvelocity = JUMPSPD;
		}

		// this is weird: c# multiplication operator isn't commutative:
		// new Vector3(...) * transform.rotation doesn't work, but this does:
		Vector3 spd = transform.rotation * new Vector3 (sidespd, verticalvelocity, forwardspd);
		cc.Move (spd * Time.deltaTime);
	}
}

