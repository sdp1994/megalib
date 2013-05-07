/*
 * MCAngerCameraHit.hh
 *
 * Copyright (C) by Andreas Zoglauer.
 * All rights reserved.
 *
 * Please see the source-file for the copyright-notice.
 *
 */



/******************************************************************************
 *
 * Class representing a hit in a calorimeter bar
 * The represented data is the position in bar numbers and absolute position
 * as well as the energy in ADCounts and keV
 *
 */

#ifndef ___MCAngerCameraHit___
#define ___MCAngerCameraHit___

// Geant4:
#include "G4VHit.hh"
#include "G4THitsCollection.hh"
#include "G4Allocator.hh"
#include "G4ThreeVector.hh"

// Cosima:
#include "MCVHit.hh"


/******************************************************************************/


class MCAngerCameraHit : public MCVHit
{
public:
  /// Default constructor
  MCAngerCameraHit();
  /// Default destructor
  ~MCAngerCameraHit();
  /// Default copy constructor
  MCAngerCameraHit(const MCAngerCameraHit&);
  /// Default assignment constructor
  const MCAngerCameraHit& operator=(const MCAngerCameraHit&);

  /// Is-Equal operator
  int operator==(MCAngerCameraHit&);
  /// Addition operator
  const MCAngerCameraHit& operator+=(const MCAngerCameraHit&);
  
  /// Special Geant4 memory allocation
  inline void* operator new(size_t);
  /// Special Geant4 memory deallocation
  inline void  operator delete(void*);
  
  /// Return the data as calibrated hit (as position and energy)
  MSimHT* GetCalibrated();

  /// Set the location of the hit in the world coordinate system
  inline void SetPosition(G4ThreeVector Position) { m_Position = Position; }
  /// Return the position in the world coordinate system
  inline G4ThreeVector GetPosition() { return m_Position; };

  /// Dump the hit
  void Print();

private:
    /// Absolute Position of the hit in the world reference frame
  G4ThreeVector m_Position;
};


/******************************************************************************/


typedef G4THitsCollection<MCAngerCameraHit> MCAngerCameraHitsCollection;

extern G4Allocator<MCAngerCameraHit> MCAngerCameraHitAllocator;

inline void* MCAngerCameraHit::operator new(size_t)
{
  void* NewHit;
  NewHit = (void*) MCAngerCameraHitAllocator.MallocSingle();
  return NewHit;
}

inline void MCAngerCameraHit::operator delete(void* Hit)
{
  MCAngerCameraHitAllocator.FreeSingle((MCAngerCameraHit*) Hit);
}

#endif


/*
 * MCAngerCameraHit.hh: the end...
 ******************************************************************************/








