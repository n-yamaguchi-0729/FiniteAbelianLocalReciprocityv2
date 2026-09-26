import Mathlib.RingTheory.Norm.Basic
import Mathlib.GroupTheory.QuotientGroup.Basic
import Mathlib.FieldTheory.Galois.Abelian
import Mathlib.NumberTheory.LocalField.Basic
import Mathlib.Topology.Algebra.ContinuousMonoidHom
import Mathlib.Topology.Algebra.Group.Quotient
import Mathlib.FieldTheory.KrullTopology

set_option autoImplicit false

/-!
# Finite abelian local reciprocity: norm-quotient form

For a finite abelian extension `L / K` of a nonarchimedean local field, the
quotient of `Kˣ` by the subgroup of field norms from `Lˣ` is isomorphic, as a
topological group, to `Gal(L / K)`.

This is the compact finite norm-quotient form of local reciprocity. It does
not by itself record a Frobenius normalization, compatibility in towers, or
the local existence theorem; those are separate results in the substantive
ClassFieldTheory development and are described in the README.
-/

noncomputable section

namespace ClassFieldTheory

universe u v

/-- The field norm on multiplicative groups. -/
def fieldNormHom
    (K : Type u) (L : Type v)
    [Field K] [Field L] [Algebra K L] [FiniteDimensional K L] :
    Lˣ →* Kˣ :=
  Units.map (Algebra.norm K)

/-- The subgroup `N_{L/K}(Lˣ)` of nonzero field norms. -/
def fieldNormSubgroup
    (K : Type u) (L : Type v)
    [Field K] [Field L] [Algebra K L] [FiniteDimensional K L] :
    Subgroup Kˣ :=
  (fieldNormHom K L).range

/-- The norm quotient `Kˣ / N_{L/K}(Lˣ)`. -/
abbrev FieldNormQuotient
    (K : Type u) (L : Type v)
    [Field K] [Field L] [Algebra K L] [FiniteDimensional K L] :=
  Kˣ ⧸ fieldNormSubgroup K L

/-- Finite abelian local reciprocity in norm-quotient form. -/
theorem finiteAbelianLocalReciprocity_quotient
    (K L : Type)
    [Field K] [Field L] [Algebra K L]
    [FiniteDimensional K L] [IsAbelianGalois K L]
    [ValuativeRel K] [TopologicalSpace K]
    [IsNonarchimedeanLocalField K] :
    Nonempty (FieldNormQuotient K L ≃ₜ* (L ≃ₐ[K] L)) := by
  sorry

end ClassFieldTheory
