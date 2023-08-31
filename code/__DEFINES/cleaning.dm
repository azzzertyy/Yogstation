// Cleaning flags

///Whether we should not attempt to clean.
#define DO_NOT_CLEAN "do_not_clean"

// Different kinds of things that can be cleaned.
// Use these when overriding the wash proc or registering for the clean signals to check if your thing should be cleaned
/// Cleans blood off of the cleanable atom.
#define CLEAN_TYPE_BLOOD (1 << 0)
/// Cleans visible blood off of the cleanable atom, but not the chemicals.
#define CLEAN_TYPE_VISIBLE_BLOOD (1 << 1)
/// Cleans fingerprints off of the cleanable atom.
#define CLEAN_TYPE_FINGERPRINTS (1 << 2)
/// Cleans fibres off of the cleanable atom.
#define CLEAN_TYPE_FIBERS (1 << 3)
/// Cleans radiation off of the cleanable atom.
#define CLEAN_TYPE_RADIATION (1 << 4)
/// Cleans diseases off of the cleanable atom.
#define CLEAN_TYPE_DISEASE (1 << 5)
/// Cleans acid off of the cleanable atom.
#define CLEAN_TYPE_ACID (1 << 6)
/// Cleans decals such as dirt and oil off the floor
#define CLEAN_TYPE_LIGHT_DECAL (1 << 7)
/// Cleans decals such as cobwebs off the floor
#define CLEAN_TYPE_HARD_DECAL (1 << 8)

//Yog specific cleaning flags
/// Cleans radiation slowly
#define CLEAN_TYPE_WEAK (1 << 8)
/// Cleans cult runes
#define CLEAN_TYPE_RUNES (1 << 9)

// Different cleaning methods.
// Use these when calling the wash proc for your cleaning apparatus

/// Cleans most visible markings
#define CLEAN_WASH (CLEAN_TYPE_VISIBLE_BLOOD | CLEAN_TYPE_DISEASE | CLEAN_TYPE_ACID | CLEAN_TYPE_LIGHT_DECAL | CLEAN_TYPE_RUNES)
///Cleans all visible markings, fingerprints & fibres
#define CLEAN_SCRUB (CLEAN_WASH | CLEAN_TYPE_FINGERPRINTS | CLEAN_TYPE_FIBERS | CLEAN_TYPE_HARD_DECAL)
/// Cleans blood DNA
#define CLEAN_FULL_SCRUB (CLEAN_SCRUB | CLEAN_TYPE_BLOOD)
/// Cleans rads
#define CLEAN_RAD CLEAN_TYPE_RADIATION
/// Cleans everything
#define CLEAN_ALL (ALL & ~CLEAN_TYPE_WEAK)
