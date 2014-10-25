using UnityEngine;
using System.Collections;

public class FPSCtrl : MonoBehaviour {

	public float movementspeed;
	public float updownmousesensitivity;
	public float leftrightmousesensitivity;
	public float updowncamrange;

	Vector3 updownangles = Vector3.zero;

	// Use this for initialization
	void Start () {
		// gotta init variables here otw it won't update in the editor
		movementspeed = 10f;
		updownmousesensitivity = 200f;
		leftrightmousesensitivity = 2f;
		updowncamrange = 60f; // angle in degrees
		Camera.main.transform.localEulerAngles = updownangles;

		Screen.lockCursor = true; // hides mouse pointer
	}
	
	// Update is called once per frame
	void Update () {
		// rotation
		float mouseleftright = Input.GetAxis ("Mouse X") * leftrightmousesensitivity;
		transform.Rotate (0, mouseleftright, 0);

		updownangles.x -= Input.GetAxis ("Mouse Y") * updownmousesensitivity * Time.deltaTime;
		updownangles.x = Mathf.Clamp (updownangles.x, -updowncamrange, updowncamrange);
		Camera.main.transform.localEulerAngles = updownangles;

		// movement
		float forwardspd = Input.GetAxis ("Vertical") * movementspeed;
		float sidespd = Input.GetAxis ("Horizontal") * movementspeed;
		// this is weird: c# multiplication operator isn't commutative:
		// new Vector3(...) * transform.rotation doesn't work, but this does:
		Vector3 spd = transform.rotation * new Vector3 (sidespd, 0, forwardspd);
		CharacterController cc = GetComponent<CharacterController> ();
		cc.SimpleMove (spd);
	}
}

