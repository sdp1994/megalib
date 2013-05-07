/*
 * MDDriftChamber.h
 *
 * Copyright (C) by Andreas Zoglauer.
 * All rights reserved.
 *
 * Please see the source-file for the copyright-notice.
 *
 */


#ifndef __MDDriftChamber__
#define __MDDriftChamber__


////////////////////////////////////////////////////////////////////////////////


// ROOT libs:
#include <MString.h>

// MEGAlib libs:
#include "MGlobal.h"
#include "MDStrip3D.h"
#include "MStreams.h"

// Forward declarations:


////////////////////////////////////////////////////////////////////////////////


class MDDriftChamber : public MDStrip3D
{
  // public interface:
 public:
  MDDriftChamber(MString Name = "");
  MDDriftChamber(const MDDriftChamber& D);
  virtual ~MDDriftChamber();

  virtual MDDetector* Clone();

  virtual void Noise(MVector& Pos, double& Energy, double& Time, MDVolume* Volume) const;
  virtual bool NoiseLightEnergy(double& Energy) const;
  virtual vector<MDGridPoint> Discretize(const MVector& Pos, const double& Energy, const double& Time, MDVolume* Volume) const;

  void SetLightSpeed(const double LightSpeed) { m_LightSpeed = LightSpeed; }
  double GetLightSpeed() const { return m_LightSpeed; }
  void SetLightDetectorPosition(const int Pos) { m_LightDetectorPosition = Pos; }
  int GetLightDetectorPosition() const { return m_LightDetectorPosition; }
  void SetDriftConstant(const double DriftConstant) { m_DriftConstant = DriftConstant; }
  double GetDriftConstant() const { return m_DriftConstant; }
  void SetEnergyPerElectron(const double EnergyPerElectron) { m_EnergyPerElectron = EnergyPerElectron; }
  double GetEnergyPerElectron() const { return m_EnergyPerElectron; }

  void SetLightEnergyResolution(const double Energy, const double Resolution);
  virtual double GetLightEnergyResolution(const double Energy) const;

  //! Return the travel time between the interaction position and the PMTs
  double GetLightTravelTime(const MVector& Position) const;


  virtual MString GetGeomega() const;
  virtual MString GetGeant3() const;
  virtual MString GetMGeant() const;
  virtual MString ToString() const;

  // protected methods:
 protected:


  // private methods:
 private:



  // protected members:
 protected:
  

  // private members:
 private:
  //! Speed of (optical) light in the detector material
  double m_LightSpeed;
  //! Position of the light sensitive detector (1: +x; -1:-x; 2: +y; -2 -y; 3: +z; -3:-z)
  int m_LightDetectorPosition;
  //! Constant describing the opening cone of the drift: c * sqrt(Drift Length)
  double m_DriftConstant;
  //! Energy per drfiting electron
  double m_EnergyPerElectron;

  //! Vector golding the energy resolution as one sigma in keV of the energy
  //! measured by the light
  MSpline* m_LightEnergyResolution; 

#ifdef ___CINT___
 public:
  ClassDef(MDDriftChamber, 0) // no description
#endif

};

#endif


////////////////////////////////////////////////////////////////////////////////
