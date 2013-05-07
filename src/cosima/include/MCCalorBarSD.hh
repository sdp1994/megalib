/*
 * MCCalorBarSD.hh
 *
 * Copyright (C) by Andreas Zoglauer.
 * All rights reserved.
 *
 * Please see the source-file for the copyright-notice.
 *
 */


/******************************************************************************
 *
 * Class representing the sensitive detector of a calorimeter bar
 *
 */

#ifndef ___MCCalorBarSD___
#define ___MCCalorBarSD___

// Geant4:
#include "G4VSensitiveDetector.hh"
#include "globals.hh"

// Cosima:
#include "MCCalorBarHit.hh"
#include "MCSD.hh"

// Forward declarations:
class G4HCofThisEvent;
class G4Step;


/******************************************************************************/


class MCCalorBarSD : public MCSD
{
  // public interface:
public:
  ///  Set name, type and collection 
  MCCalorBarSD(G4String Name);
  /// Default constructor
  ~MCCalorBarSD();
  
  /// Set whether or not this is a 3D calorimeter bar (z-resolution or not)
  void SetIs3D(bool Is3D = true) { m_Is3D = Is3D; }
  
  /// Create hit collection if not yet done
  void Initialize(G4HCofThisEvent* HCof);
  /// Analyze and store the hits
  G4bool ProcessHits(G4Step* astep, G4TouchableHistory* ROHist);
  /// Generate and store the hits 
  G4bool PostProcessHits(const G4Step* Step);
  /// Transfer hits to geant
  void EndOfEvent(G4HCofThisEvent* HCof);


  // protected methods:
protected:
  

  // protected members:
protected:


  // private members:
private:
  /// Container for the hits of one event
  MCCalorBarHitsCollection* m_HitCollection;      

  /// True if this calorimeter has z-resolution:
  bool m_Is3D;
};

#endif


/*
 * MCCalorBarSD.hh: the end...
 ******************************************************************************/





