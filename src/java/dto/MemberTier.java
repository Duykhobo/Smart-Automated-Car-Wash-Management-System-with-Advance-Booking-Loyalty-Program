package dto;

public class MemberTier {
    private int tierId;
    private String tierName;
    private int minWashes;
    private double minSpend;
    private double pointsModifier;
    private int priorityRank;

    public MemberTier() {}

    public MemberTier(int tierId, String tierName, int minWashes, double minSpend, double pointsModifier, int priorityRank) {
        this.tierId = tierId;
        this.tierName = tierName;
        this.minWashes = minWashes;
        this.minSpend = minSpend;
        this.pointsModifier = pointsModifier;
        this.priorityRank = priorityRank;
    }

    public int getTierId() { return tierId; }
    public void setTierId(int tierId) { this.tierId = tierId; }
    public String getTierName() { return tierName; }
    public void setTierName(String tierName) { this.tierName = tierName; }
    public int getMinWashes() { return minWashes; }
    public void setMinWashes(int minWashes) { this.minWashes = minWashes; }
    public double getMinSpend() { return minSpend; }
    public void setMinSpend(double minSpend) { this.minSpend = minSpend; }
    public double getPointsModifier() { return pointsModifier; }
    public void setPointsModifier(double pointsModifier) { this.pointsModifier = pointsModifier; }
    public int getPriorityRank() { return priorityRank; }
    public void setPriorityRank(int priorityRank) { this.priorityRank = priorityRank; }
}
